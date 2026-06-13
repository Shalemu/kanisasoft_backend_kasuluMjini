<?php

namespace App\Swagger;

class AuthPaths
{
    /**
     * @OA\Post(
     *     path="/api/register",
     *     tags={"Authentication"},
     *     summary="Register a new user and member profile",
     *
     *     @OA\RequestBody(required=true, @OA\JsonContent(ref="#/components/schemas/RegisterRequest")),
     *
     *     @OA\Response(response=200, description="Registered", @OA\JsonContent(ref="#/components/schemas/LoginResponse")),
     *     @OA\Response(response=422, description="Validation error", @OA\JsonContent(ref="#/components/schemas/ApiError")),
     *     @OA\Response(response=500, description="Server error", @OA\JsonContent(ref="#/components/schemas/ApiError"))
     * )
     */
    public function register(): void {}

    /**
     * @OA\Post(
     *     path="/api/login",
     *     tags={"Authentication"},
     *     summary="Login with email or phone number",
     *     description="Use the returned token in Swagger UI's Authorize button as a Bearer token.",
     *
     *     @OA\RequestBody(required=true, @OA\JsonContent(ref="#/components/schemas/LoginRequest")),
     *
     *     @OA\Response(response=200, description="Login successful", @OA\JsonContent(ref="#/components/schemas/LoginResponse")),
     *     @OA\Response(response=401, description="Invalid credentials", @OA\JsonContent(ref="#/components/schemas/ApiError")),
     *     @OA\Response(response=403, description="User is not approved", @OA\JsonContent(ref="#/components/schemas/ApiError")),
     *     @OA\Response(response=422, description="Validation error", @OA\JsonContent(ref="#/components/schemas/ApiError"))
     * )
     */
    public function login(): void {}

    /**
     * @OA\Post(
     *     path="/api/logout",
     *     tags={"Authentication"},
     *     summary="Logout the current Sanctum token",
     *     security={{"bearerAuth": {}}},
     *
     *     @OA\Response(response=200, description="Logged out", @OA\JsonContent(ref="#/components/schemas/ApiSuccess")),
     *     @OA\Response(response=401, description="Unauthenticated", @OA\JsonContent(ref="#/components/schemas/ApiError"))
     * )
     */
    public function logout(): void {}

    /**
     * @OA\Get(
     *     path="/api/mtumiaji",
     *     tags={"Authentication"},
     *     summary="Get the current user's member profile",
     *     security={{"bearerAuth": {}}},
     *
     *     @OA\Response(response=200, description="Current member profile", @OA\JsonContent(type="object")),
     *     @OA\Response(response=401, description="Unauthenticated", @OA\JsonContent(ref="#/components/schemas/ApiError"))
     * )
     */
    public function currentUser(): void {}

    /**
     * @OA\Get(
     *     path="/api/mtumiaji/profile",
     *     tags={"Authentication"},
     *     summary="Get the current user's member profile",
     *     security={{"bearerAuth": {}}},
     *
     *     @OA\Response(response=200, description="Current member profile", @OA\JsonContent(type="object")),
     *     @OA\Response(response=401, description="Unauthenticated", @OA\JsonContent(ref="#/components/schemas/ApiError"))
     * )
     */
    public function profile(): void {}

    /**
     * @OA\Post(
     *     path="/api/user/update-profile",
     *     tags={"Authentication"},
     *     summary="Update the current user's profile",
     *     security={{"bearerAuth": {}}},
     *
     *     @OA\RequestBody(required=true, @OA\JsonContent(ref="#/components/schemas/GenericJsonRequest")),
     *
     *     @OA\Response(response=200, description="Profile updated", @OA\JsonContent(type="object")),
     *     @OA\Response(response=401, description="Unauthenticated", @OA\JsonContent(ref="#/components/schemas/ApiError")),
     *     @OA\Response(response=422, description="Validation error", @OA\JsonContent(ref="#/components/schemas/ApiError"))
     * )
     */
    public function updateProfile(): void {}

    /**
     * @OA\Get(
     *     path="/api/users",
     *     tags={"Authentication"},
     *     summary="List users and their member details",
     *     security={{"bearerAuth": {}}},
     *
     *     @OA\Response(response=200, description="Users list", @OA\JsonContent(type="object")),
     *     @OA\Response(response=401, description="Unauthenticated", @OA\JsonContent(ref="#/components/schemas/ApiError"))
     * )
     */
    public function users(): void {}

    /**
     * @OA\Get(
     *     path="/api/users/pending-registrations",
     *     tags={"Authentication"},
     *     summary="Get pending registration count and latest registrations",
     *     security={{"bearerAuth": {}}},
     *
     *     @OA\Response(response=200, description="Pending registrations", @OA\JsonContent(type="object"))
     * )
     */
    public function pendingRegistrations(): void {}

    /**
     * @OA\Post(
     *     path="/api/user/change-password",
     *     tags={"Authentication"},
     *     summary="Change the authenticated user's password",
     *     security={{"bearerAuth": {}}},
     *
     *     @OA\RequestBody(
     *         required=true,
     *
     *         @OA\JsonContent(
     *             required={"current_password", "new_password", "new_password_confirmation"},
     *
     *             @OA\Property(property="current_password", type="string", format="password", example="oldsecret"),
     *             @OA\Property(property="new_password", type="string", format="password", example="newsecret"),
     *             @OA\Property(property="new_password_confirmation", type="string", format="password", example="newsecret")
     *         )
     *     ),
     *
     *     @OA\Response(response=200, description="Password changed", @OA\JsonContent(ref="#/components/schemas/ApiSuccess")),
     *     @OA\Response(response=401, description="Unauthenticated", @OA\JsonContent(ref="#/components/schemas/ApiError")),
     *     @OA\Response(response=422, description="Validation error or current password is incorrect", @OA\JsonContent(ref="#/components/schemas/ApiError"))
     * )
     */
    public function changePassword(): void {}

    /**
     * @OA\Post(
     *     path="/api/forgot-password",
     *     tags={"Authentication"},
     *     summary="Send a password reset link",
     *
     *     @OA\RequestBody(
     *         required=true,
     *
     *         @OA\JsonContent(required={"email"}, @OA\Property(property="email", type="string", format="email", example="member@example.com"))
     *     ),
     *
     *     @OA\Response(response=200, description="Reset link sent", @OA\JsonContent(ref="#/components/schemas/ApiSuccess")),
     *     @OA\Response(response=422, description="Validation error", @OA\JsonContent(ref="#/components/schemas/ApiError"))
     * )
     */
    public function forgotPassword(): void {}

    /**
     * @OA\Post(
     *     path="/api/reset-password",
     *     tags={"Authentication"},
     *     summary="Reset a user's password",
     *
     *     @OA\RequestBody(
     *         required=true,
     *
     *         @OA\JsonContent(
     *             required={"email", "password", "password_confirmation"},
     *
     *             @OA\Property(property="email", type="string", format="email", example="member@example.com"),
     *             @OA\Property(property="password", type="string", format="password", example="newsecret"),
     *             @OA\Property(property="password_confirmation", type="string", format="password", example="newsecret")
     *         )
     *     ),
     *
     *     @OA\Response(response=200, description="Password reset", @OA\JsonContent(ref="#/components/schemas/ApiSuccess")),
     *     @OA\Response(response=404, description="User not found", @OA\JsonContent(ref="#/components/schemas/ApiError")),
     *     @OA\Response(response=422, description="Validation error", @OA\JsonContent(ref="#/components/schemas/ApiError"))
     * )
     */
    public function resetPassword(): void {}

    /**
     * @OA\Post(
     *     path="/api/users/{id}/reject",
     *     tags={"Authentication"},
     *     summary="Reject a pending user/member",
     *     security={{"bearerAuth": {}}},
     *
     *     @OA\Parameter(name="id", in="path", required=true, @OA\Schema(type="integer")),
     *
     *     @OA\RequestBody(required=true, @OA\JsonContent(required={"reason"}, @OA\Property(property="reason", type="string", example="Registration details could not be verified"))),
     *
     *     @OA\Response(response=200, description="User rejected", @OA\JsonContent(type="object")),
     *     @OA\Response(response=401, description="Unauthenticated", @OA\JsonContent(ref="#/components/schemas/ApiError")),
     *     @OA\Response(response=404, description="User or member not found", @OA\JsonContent(ref="#/components/schemas/ApiError")),
     *     @OA\Response(response=422, description="Validation error", @OA\JsonContent(ref="#/components/schemas/ApiError"))
     * )
     */
    public function rejectUser(): void {}
}
