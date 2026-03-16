<?php

namespace App\Services;

use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;

class SMSService
{
    /**
     * Send SMS via MSHASTRA JSON API
     *
     * @param string 
     * @param string 
     * @return array  
     */
    public function sendSMS(string $phone, string $message): array
    {
        $payload = [
            [
                'user' => config('services.mshastra.user'),
                'pwd' => config('services.mshastra.password'),
                'number' => $phone,
                'msg' => $message,
                'sender' => config('services.mshastra.sender'),
                'language' => 'English',
            ]
        ];

        try {
            $response = Http::post(config('services.mshastra.json_url'), $payload);
            $body = $response->body();

            if (!$response->successful()) {
                Log::error('SMS request failed: ' . $body);
                $errorType = stripos($body, 'Invalid Password') !== false ? 'Invalid Password' : 'Other';
                return [
                    'status' => false,
                    'response' => $body,
                    'error_type' => $errorType,
                ];
            }

            // Check for failure keywords in body
            if (stripos($body, 'Invalid Password') !== false) {
                return [
                    'status' => false,
                    'response' => $body,
                    'error_type' => 'Invalid Password',
                ];
            }

            if (stripos($body, 'success') !== false || stripos($body, 'Sent') !== false) {
                return [
                    'status' => true,
                    'response' => $body,
                    'error_type' => null,
                ];
            }

            // If other failure
            return [
                'status' => false,
                'response' => $body,
                'error_type' => 'Other',
            ];

        } catch (\Throwable $e) {
            Log::error('SMS sending error: ' . $e->getMessage());
            return [
                'status' => false,
                'response' => $e->getMessage(),
                'error_type' => 'Exception',
            ];
        }
    }
}