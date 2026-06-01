<?php

return [

    'stateful' => [],

    'guard' => [],

    'expiration' => null,

    'token_prefix' => env('SANCTUM_TOKEN_PREFIX', ''),

    'middleware' => [
        'authenticate_session' => null,
        'encrypt_cookies' => null,
        'validate_csrf_token' => null, // ✅ DISABLED
    ],
];
