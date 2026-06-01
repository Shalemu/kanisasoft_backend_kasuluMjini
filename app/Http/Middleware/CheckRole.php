<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;

class CheckRole
{
    /**
     * Handle an incoming request.
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @param  mixed ...$roles  Roles allowed to access route
     * @return mixed
     */
    public function handle(Request $request, Closure $next, ...$roles)
    {
        $user = $request->user();

        if (!$user) {
            return response()->json(['message' => 'Unauthorized'], 401);
        }

        // Check if user's role is in allowed roles
        if (!in_array($user->role, $roles)) {
            return response()->json(['message' => 'Forbidden — you do not have permission'], 403);
        }

        return $next($request);
    }
}
