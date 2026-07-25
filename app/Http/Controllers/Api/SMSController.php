<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\User;
use App\Models\Member;
use App\Models\Group;
use App\Models\SmsLog;
use App\Services\SMSService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Mail;

class SMSController extends Controller
{
    /**
     * Send SMS via MSHASTRA and optional Email
     */
    public function send(Request $request)
    {
        $request->validate([
            'type' => 'nullable|string',        // all, male, female, group, individual
            'receiver' => 'nullable',           // group name or individual name/phone/id
            'recipient_type' => 'nullable|string',
            'target_type' => 'nullable|string',
            'member_id' => 'nullable',
            'user_id' => 'nullable',
            'recipient_id' => 'nullable',
            'selected_member_id' => 'nullable',
            'group_id' => 'nullable',
            'message' => 'required|string',
            'phone' => 'nullable|string',       // direct phone
            'email' => 'nullable|email',        // direct email
            'name' => 'nullable|string',        // name for direct notification
            'send_email' => 'nullable|boolean', // send email if true
        ]);

        $type = $request->type ?? $request->recipient_type ?? $request->target_type;
        [$receiver, $receiverField] = $this->firstFilledWithField($request, [
            'receiver',
            'member_id',
            'user_id',
            'recipient_id',
            'selected_member_id',
            'group_id',
        ]);
        $message = $request->message;
        $directPhone = $request->phone ? $this->formatTanzaniaPhone($request->phone) : null;
        $directEmail = $request->email;
        $name = $request->name ?? 'Recipient';
        $sendEmail = $request->send_email ?? false;

        $recipients = collect();
        $selectedRecipientFields = ['member_id', 'user_id', 'recipient_id', 'selected_member_id'];

        // Direct send
        if (($directPhone || $directEmail) && ! $receiver) {
            if ($directPhone && ! $this->isValidTanzaniaPhone($directPhone)) {
                $this->logSmsAttempt($directPhone, $receiver ?? $name, $type ?? 'direct', $message, 'Failed', [
                    'error' => 'Invalid phone number. Use 0XXXXXXXXX, 255XXXXXXXXX, or +255XXXXXXXXX.',
                ]);

                return response()->json([
                    'status' => 'error',
                    'message' => 'Invalid phone number. Use 0XXXXXXXXX, 255XXXXXXXXX, or +255XXXXXXXXX.',
                ], 422);
            }

            $recipients->push((object)[
                'phone' => $directPhone,
                'email' => $directEmail,
                'name' => $name
            ]);
        } else {
            $normalizedType = strtolower((string) $type);

            if (
                $receiver
                && (
                    in_array($receiverField, $selectedRecipientFields, true)
                    || in_array($normalizedType, ['washiriki', 'members'], true)
                )
            ) {
                $recipients = $this->resolveIndividualRecipients($receiver, $receiverField);
            } else {
                // Lookup recipients by type
                switch ($normalizedType) {
                    case 'all':
                        $recipients = User::all();
                        break;
                    case 'washiriki':
                    case 'members':
                        $recipients = Member::with('user:id,phone,email')
                            ->where('membership_status', 'active')
                            ->get();
                        break;
                    case 'male':
                    case 'm':
                        $recipients = User::where('gender', 'M')->get();
                        break;
                    case 'female':
                    case 'f':
                        $recipients = User::where('gender', 'F')->get();
                        break;
                    case 'group':
                        $group = Group::query()
                            ->when(
                                $receiverField === 'group_id' || ctype_digit((string) $receiver),
                                fn ($query) => $query->whereKey((int) $receiver),
                                fn ($query) => $query->where('name', $receiver)
                            )
                            ->first();
                        if ($group) {
                            $recipients = $group->members()
                                ->with('user:id,phone,email')
                                ->get();
                        }
                        break;
                    case 'individual':
                    case 'mshiriki':
                    case 'mshirika':
                    case 'member':
                    case 'mtumiaji':
                    case 'user':
                    case 'single':
                    case 'specific':
                    case 'selected':
                        $recipients = $this->resolveIndividualRecipients($receiver, $receiverField);
                        break;
                    default:
                        if ($receiver) {
                            $recipients = $this->resolveIndividualRecipients($receiver, $receiverField);
                        }

                        if ($recipients->isEmpty()) {
                            return response()->json([
                                'status' => 'error',
                                'message' => 'Invalid type provided or no direct phone/email.',
                                'received_type' => $type,
                                'received_receiver' => $receiver,
                            ], 422);
                        }
                }
            }
        }

        if ($recipients->isEmpty()) {
            return response()->json([
                'status' => 'error',
                'message' => 'No recipients found.'
            ], 400);
        }

        $smsResults = [];
        $emailResults = [];
        $sentCount = 0;
        $failedCount = 0;
        $invalidCount = 0;
        $duplicateCount = 0;
        $processedPhones = [];
        $smsService = app(SMSService::class);

        foreach ($recipients as $recipient) {
            $recipientName = $recipient->name ?? $recipient->full_name ?? 'Recipient';
            $recipientPhone = $recipient->phone_number
                ?? $recipient->user?->phone
                ?? $recipient->member?->phone_number
                ?? $recipient->phone
                ?? null;
            $recipientEmail = $recipient->email
                ?? $recipient->user?->email
                ?? $recipient->member?->email
                ?? null;

            // Send SMS
            if ($recipientPhone) {
                $formattedPhone = $this->formatTanzaniaPhone($recipientPhone);
                if (! $this->isValidTanzaniaPhone($formattedPhone)) {
                    $invalidCount++;
                    $failedCount++;
                    $smsResults[$recipientName] = 'Failed: Invalid phone number';
                    $this->logSmsAttempt($recipientPhone, $receiver ?? $recipientName, $type ?? 'direct', $message, 'Failed', [
                        'error' => 'Invalid phone number',
                        'formatted_phone' => $formattedPhone,
                    ]);

                    continue;
                }

                if (isset($processedPhones[$formattedPhone])) {
                    $duplicateCount++;
                    $smsResults[$recipientName] = 'Skipped: duplicate phone number';

                    continue;
                }

                $processedPhones[$formattedPhone] = true;
                $dedupeKey = 'sms:recent:'.sha1($formattedPhone.'|'.$message);

                if (! Cache::add($dedupeKey, true, now()->addSeconds(30))) {
                    $duplicateCount++;
                    $smsResults[$recipientName] = 'Skipped: duplicate recent SMS';

                    continue;
                }

                try {
                    $result = $smsService->sendSMS($formattedPhone, $message);
                    $smsStatus = $result['status'] ? 'Sent' : 'Failed';

                    if ($result['status']) {
                        $sentCount++;
                        $smsResults[$recipientName] = 'Sent';
                    } else {
                        Cache::forget($dedupeKey);
                        $failedCount++;
                        $smsResults[$recipientName] = 'Failed: '.($result['error_type'] ?? 'SMS provider error');
                    }

                    $this->logSmsAttempt($formattedPhone, $receiver ?? $recipientName, $type ?? 'direct', $message, $smsStatus, $result);

                } catch (\Exception $e) {
                    Cache::forget($dedupeKey);
                    $failedCount++;
                    Log::error("SMS failed for {$recipientPhone}: ".$e->getMessage());
                    $smsResults[$recipientName] = 'Failed: '.$e->getMessage();
                    $this->logSmsAttempt($formattedPhone, $receiver ?? $recipientName, $type ?? 'direct', $message, 'Failed', [
                        'error' => $e->getMessage(),
                    ]);
                }
            }

            // Send Email if requested
            if ($sendEmail && $recipientEmail) {
                try {
                    $member = Member::where('email', $recipientEmail)
                        ->orWhere('phone_number', $recipientPhone)
                        ->first();

                    $membershipNumber = 'N/A';

                    if ($member) {
                        $membershipNumber = $member->membership_number;
                    }

                    Mail::to($recipientEmail)->send(
                        new \App\Mail\MemberAuthorizedMail($recipientName, $membershipNumber)
                    );

                    $emailResults[$recipientName] = 'Sent';
                } catch (\Exception $e) {
                    Log::error("Email failed for {$recipientEmail}: " . $e->getMessage());
                    $emailResults[$recipientName] = 'Failed: ' . $e->getMessage();
                }
            }
        }

        return response()->json([
            'status' => $failedCount > 0 ? 'partial_success' : 'success',
            'message' => $failedCount > 0
                ? 'Notifications processed with some failures.'
                : 'Notifications sent successfully.',
            'summary' => [
                'recipients' => $recipients->count(),
                'sms_sent' => $sentCount,
                'sms_failed' => $failedCount,
                'invalid_phone_numbers' => $invalidCount,
                'duplicates_skipped' => $duplicateCount,
            ],
            'sms_results' => $smsResults,
            'email_results' => $emailResults,
        ]);
    }

    private function formatTanzaniaPhone(string $phone): string
    {
        $num = preg_replace('/\D/', '', $phone);

        if (str_starts_with($num, '0')) {
            return '255'.substr($num, 1);
        }

        if (strlen($num) === 9) {
            return '255'.$num;
        }

        return $num;
    }

    private function firstFilledWithField(Request $request, array $fields): array
    {
        foreach ($fields as $field) {
            if ($request->filled($field)) {
                return [(string) $request->input($field), $field];
            }
        }

        return [null, null];
    }

    private function resolveIndividualRecipients(?string $receiver, ?string $receiverField = null)
    {
        if (! $receiver) {
            return collect();
        }

        $formattedPhone = $this->formatTanzaniaPhone($receiver);

        if (in_array($receiverField, ['member_id', 'selected_member_id'], true)) {
            $member = Member::find($receiver);

            return $member ? collect([$member]) : collect();
        }

        if ($receiverField === 'user_id') {
            $user = User::with('member')->find($receiver);

            return $user ? collect([$user]) : collect();
        }

        if ($receiverField === 'recipient_id') {
            $member = Member::find($receiver);
            if ($member) {
                return collect([$member]);
            }

            $user = User::with('member')->find($receiver);

            return $user ? collect([$user]) : collect();
        }

        $member = Member::where('full_name', $receiver)
            ->orWhere('membership_number', $receiver)
            ->orWhere('phone_number', $receiver)
            ->orWhere('phone_number', $formattedPhone)
            ->orWhere('email', $receiver)
            ->first();

        if ($member) {
            return collect([$member]);
        }

        $user = User::where('full_name', $receiver)
            ->orWhere('phone', $receiver)
            ->orWhere('phone', $formattedPhone)
            ->orWhere('email', $receiver)
            ->when(is_numeric($receiver), fn ($query) => $query->orWhere('id', $receiver))
            ->first();

        return $user ? collect([$user->load('member')]) : collect();
    }

    private function isValidTanzaniaPhone(?string $phone): bool
    {
        return is_string($phone) && preg_match('/^255[0-9]{9}$/', $phone) === 1;
    }

    private function logSmsAttempt(string $recipient, string $receiver, string $type, string $message, string $status, array $response = []): void
    {
        SmsLog::create([
            'recipient' => $recipient,
            'receiver' => $receiver,
            'type' => $type,
            'message' => $message,
            'status' => $status,
            'response' => $response,
        ]);
    }

    public function logs()
    {
       $logs = SmsLog::latest()->get()->map(function ($log) {
            return [
                'id' => $log->id,
                'recipient' => $log->recipient,
                'receiver' => $log->receiver,
                'type' => $log->type,
                'message' => $log->message,
                'status' => $log->status,
                'response' => $log->response,
                'sent_at' => $log->created_at->format('Y-m-d H:i:s'),
            ];
        });

        return response()->json([
            'status' => 'success',
            'logs' => $logs,
        ]);
    }
}
