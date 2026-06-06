<?php

return [

    'paths' => [
        'api/*',
        'login',
        'logout',
        'register',
        // 'sanctum/csrf-cookie', 
    ],

    'allowed_methods' => ['*'],

    'allowed_origins' => [
        'https://churchapp.co.tz',
        // 'https://fpctchamwino.kanisasoft.co.tz',
        'https://fpctkurasini.kanisasoft.co.tz',
        'http://localhost:3000',
    ],

    'allowed_origins_patterns' => [],

    'allowed_headers' => ['*'],

    'exposed_headers' => [],

    'max_age' => 0,

    'supports_credentials' => false, 
];
