<?php

namespace App\Http\Middleware;

use Illuminate\Foundation\Http\Middleware\VerifyCsrfToken as Middleware;

class VerifyCsrfToken extends Middleware
{
    /**
     * Indicates whether the XSRF-TOKEN cookie should be set on the response.
     *
     * Since we're disabling CSRF, we can turn this off too.
     *
     * @var bool
     */
    protected $addHttpCookie = false;

    /**
     * The URIs that should be excluded from CSRF verification.
     *
     * This wildcard disables CSRF for all routes.
     *
     * @var array<int, string>
     */
    protected $except = [
        '*', // 🔥 Disables CSRF protection globally
    ];
}
