<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\User;
use App\Models\Member;
use App\Models\Group;
use App\Models\SmsLog;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Http;
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
        $directPhone = $request->phone;
        $directEmail = $request->email;
        $name = $request->name ?? 'Recipient';
        $sendEmail = $request->send_email ?? false;

        $recipients = collect();

        // Direct send
        if ($directPhone || $directEmail) {
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
                    if ($group) $recipients = $group->members()->get();
                    break;
                case 'individual':
                    $user = User::where('full_name', $receiver)
                        ->orWhere('phone', $receiver)
                        ->first();
                    if ($user) $recipients = collect([$user]);
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

        foreach ($recipients as $recipient) {
            $recipientName = $recipient->name ?? $recipient->full_name ?? 'Recipient';
            $recipientPhone = $recipient->phone ?? $recipient->phone_number ?? null;
            $recipientEmail = $recipient->email ?? null;

            // Send SMS
            if ($recipientPhone) {
                try {
                    // Format phone: take last 9 digits + 255 prefix
                    $num = preg_replace('/\D/', '', $recipientPhone);
                    $lastNine = substr($num, -9);
                    $formattedPhone = '255' . $lastNine;

                    // URL encode message
                    $msgEncoded = urlencode($message);

                    // Build GET URL
                    $url = "https://mshastra.com/sendurl.aspx?"
                        . "user=" . config('services.mshastra.user')
                        . "&pwd=" . config('services.mshastra.password')
                        . "&senderid=" . config('services.mshastra.sender')
                        . "&mobileno=" . $formattedPhone
                        . "&msgtext=" . $msgEncoded
                        . "&CountryCode=255";

                    $response = Http::get($url);
                    $body = $response->body();

                    if (stripos($body, 'success') !== false || stripos($body, 'Sent') !== false) {
                        $smsStatus = 'Sent';
                    } else {
                        $smsStatus = 'Failed: ' . $body;
                    }

                    $smsResults[$recipientName] = $smsStatus;

                    // Log SMS
                    SmsLog::create([
                        'recipient' => $formattedPhone,
                        'receiver' => $receiver ?? $recipientName,
                        'type' => $type ?? 'direct',
                        'message' => $message,
                        'status' => $smsStatus,
                        'response' => $body,
                    ]);

                } catch (\Exception $e) {
                    Log::error("SMS failed for {$recipientPhone}: " . $e->getMessage());
                    $smsResults[$recipientName] = 'Failed: ' . $e->getMessage();
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
                        if (!$member->membership_number) {
                            $member->membership_number = $this->generateMembershipNumber();
                            $member->save();
                        }
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
            'status' => 'success',
            'message' => 'Notifications processed',
            'sms_results' => $smsResults,
            'email_results' => $emailResults,
        ]);
    }

    private function generateMembershipNumber()
    {
        $lastNumber = Member::max(DB::raw('CAST(membership_number AS UNSIGNED)'));
        $newNumber = $lastNumber ? $lastNumber + 1 : 1;
        return str_pad($newNumber, 4, '0', STR_PAD_LEFT);
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