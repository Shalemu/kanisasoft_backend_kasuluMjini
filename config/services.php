<?php

return [

    /*
    |--------------------------------------------------------------------------
    | Third Party Services
    |--------------------------------------------------------------------------
    |
    | This file is for storing the credentials for third party services such
    | as Mailgun, Postmark, AWS and more. This file provides the de facto
    | location for this type of information, allowing packages to have
    | a conventional file to locate the various service credentials.
    |
    */

    'postmark' => [
        'token' => env('POSTMARK_TOKEN'),
    ],

    'ses' => [
        'key' => env('AWS_ACCESS_KEY_ID'),
        'secret' => env('AWS_SECRET_ACCESS_KEY'),
        'region' => env('AWS_DEFAULT_REGION', 'us-east-1'),
    ],

    'resend' => [
        'key' => env('RESEND_KEY'),
    ],

    'slack' => [
        'notifications' => [
            'bot_user_oauth_token' => env('SLACK_BOT_USER_OAUTH_TOKEN'),
            'channel' => env('SLACK_BOT_USER_DEFAULT_CHANNEL'),
        ],
    ],

    // 'beem' => [
    // 'api_key' => env('BEEM_API_KEY'),
    // 'secret' => env('BEEM_SECRET_KEY'),
    // 'sender' => env('BEEM_SENDER_NAME'),
    // ],

    'mshastra' => [
    'user' => env('MSHASTRA_USER'),
    'password' => env('MSHASTRA_PASSWORD'),
    'sender' => env('MSHASTRA_SENDERID'),
    'base_url' => env('MSHASTRA_BASE_URL'),
    'json_url' => env('MSHASTRA_JSON_URL'),
],




];
