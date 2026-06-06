<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\User;
use App\Models\Member;
use App\Models\Group;
use App\Models\SmsLog;
use App\Services\SMSService;
use Illuminate\Http\Request;
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
            'receiver' => 'nullable|string',    // group name or individual name/phone
            'message' => 'required|string',
            'phone' => 'nullable|string',       // direct phone
            'email' => 'nullable|email',        // direct email
            'name' => 'nullable|string',        // name for direct notification
            'send_email' => 'nullable|boolean', // send email if true
        ]);

        $type = $request->type;
        $receiver = $request->receiver;
        $message = $request->message;
        $directPhone = $request->phone ? $this->formatTanzaniaPhone($request->phone) : null;
        $directEmail = $request->email;
        $name = $request->name ?? 'Recipient';
        $sendEmail = $request->send_email ?? false;

        $recipients = collect();

        // Direct send
        if ($directPhone || $directEmail) {
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
            // Lookup recipients by type
            switch (strtolower($type)) {
                case 'all':
                    $recipients = User::all();
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
                    $group = Group::where('name', $receiver)->first();
                    if ($group) {
                        $recipients = $group->members()->get();
                    }
                    break;
                case 'individual':
                    $user = User::where('full_name', $receiver)
                        ->orWhere('phone', $receiver)
                        ->first();
                    if ($user) {
                        $recipients = collect([$user]);
                    }
                    break;
                default:
                    return response()->json([
                        'status' => 'error',
                        'message' => 'Invalid type provided or no direct phone/email.'
                    ], 422);
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
        $smsService = app(SMSService::class);

        foreach ($recipients as $recipient) {
            $recipientName = $recipient->name ?? $recipient->full_name ?? 'Recipient';
            $recipientPhone = $recipient->phone ?? $recipient->phone_number ?? null;
            $recipientEmail = $recipient->email ?? null;

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

                try {
                    $result = $smsService->sendSMS($formattedPhone, $message);
                    $smsStatus = $result['status'] ? 'Sent' : 'Failed';

                    if ($result['status']) {
                        $sentCount++;
                        $smsResults[$recipientName] = 'Sent';
                    } else {
                        $failedCount++;
                        $smsResults[$recipientName] = 'Failed: '.($result['error_type'] ?? 'SMS provider error');
                    }

                    $this->logSmsAttempt($formattedPhone, $receiver ?? $recipientName, $type ?? 'direct', $message, $smsStatus, $result);

                } catch (\Exception $e) {
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
        $logs = SmsLog::latest()->limit(100)->get()->map(function ($log) {
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
