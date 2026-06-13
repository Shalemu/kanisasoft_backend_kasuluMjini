<?php

namespace App\Exceptions;

use Throwable;
use Illuminate\Auth\AuthenticationException;
use Illuminate\Foundation\Exceptions\Handler as ExceptionHandler;
use Illuminate\Support\Facades\Log;
use Illuminate\Validation\ValidationException;
use Symfony\Component\HttpKernel\Exception\HttpExceptionInterface;

class Handler extends ExceptionHandler
{
    /**
     * Inputs that are never flashed to session.
     *
     * @var array<int, string>
     */
    protected $dontFlash = [
        'current_password',
        'new_password',
        'new_password_confirmation',
        'password',
        'password_confirmation',
    ];

    /**
     * Register exception handling.
     */
    public function register(): void
    {
        $this->reportable(function (Throwable $e) {
            Log::error('[' . $e->getCode() . '] ' . $e->getMessage(), [
                'file' => $e->getFile(),
                'line' => $e->getLine(),
            ]);
        });
    }

    /**
     * Handle unauthenticated users (Sanctum).
     */
    protected function unauthenticated($request, AuthenticationException $exception)
    {
        if ($request->expectsJson()) {
            return response()->json([
                'success' => false,
                'message' => 'Unauthenticated.'
            ], 401);
        }

        return redirect()->guest('/');
    }

    /**
     * Render exceptions.
     */
    public function render($request, Throwable $e)
    {
        // If this is an API request → always return JSON
        if ($request->expectsJson()) {
            if ($e instanceof ValidationException) {
                return response()->json([
                    'message' => $e->getMessage(),
                    'errors' => $e->errors(),
                ], 422);
            }

            if ($e instanceof AuthenticationException) {
                return response()->json([
                    'success' => false,
                    'message' => 'Unauthenticated.',
                ], 401);
            }

            $statusCode = 500;

            if ($e instanceof HttpExceptionInterface) {
                $statusCode = $e->getStatusCode();
            }

            return response()->json([
                'success' => false,
                'message' => $e->getMessage() ?: 'Server Error'
            ], $statusCode);
        }

        // Default web behavior
        return parent::render($request, $e);
    }
}
