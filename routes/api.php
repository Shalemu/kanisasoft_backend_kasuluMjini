<?php

use App\Http\Controllers\Api\AssetController;
use App\Http\Controllers\Api\AttendanceController;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\ChildrenController;
use App\Http\Controllers\Api\ContributionController;
use App\Http\Controllers\Api\ContributionTypeController;
use App\Http\Controllers\Api\EventController;
use App\Http\Controllers\Api\GalleryController;
use App\Http\Controllers\Api\GroupsController;
use App\Http\Controllers\Api\GuestsController;
use App\Http\Controllers\Api\LeaderController;
use App\Http\Controllers\Api\LeadershipRoleController;
use App\Http\Controllers\Api\MemberMarriageController;
use App\Http\Controllers\Api\MembersController;
use App\Http\Controllers\Api\ServiceController;
use App\Http\Controllers\Api\ServiceEventController;
use App\Http\Controllers\Api\SMSController;
use App\Http\Controllers\Api\UserRoleController;
use App\Http\Controllers\Api\UserSettingsController;
use App\Models\Attendance;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

//  Public routes
Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);
Route::post('/change-password', [AuthController::class, 'changePassword'])->middleware('auth:sanctum');
Route::post('/forgot-password', [AuthController::class, 'forgotPassword']);
Route::post('/reset-password', [AuthController::class, 'resetPassword']);
Route::middleware('auth:sanctum')->post('/users/assign-roles', [UserRoleController::class, 'assignRoles']);

// Public access to gallery
Route::get('/gallery', [GalleryController::class, 'index']);

//  Protected routes
Route::middleware('auth:sanctum')->group(function () {
    // Auth
    Route::post('/logout', [AuthController::class, 'logout']);
    Route::get('/mtumiaji/profile', [AuthController::class, 'me']);
    // Route::get('/mtumiaji', fn(Request $request) => $request->user());
    Route::get('/mtumiaji', [AuthController::class, 'me']);
    Route::post('/user/update-profile', [AuthController::class, 'updateProfile']);
    Route::get('/users', [AuthController::class, 'allUsers']);
    Route::get('/users/pending-registrations', [AuthController::class, 'pendingRegistrations']);
    // Reject a user (mark as rejected instead of deleting)
    Route::post('/users/{id}/reject', [AuthController::class, 'rejectUser']);

    // Members
    Route::get('/members/stats', [MembersController::class, 'stats']);
    Route::get('/members/reports', [MembersController::class, 'report']);
    Route::post('/admin/members', [MembersController::class, 'store']);
    Route::get('/member-marriages', [MemberMarriageController::class, 'index']);
    Route::post('/member-marriages', [MemberMarriageController::class, 'store']);
    Route::delete('/member-marriages/{memberMarriage}', [MemberMarriageController::class, 'destroy']);
    Route::apiResource('members', MembersController::class);
    Route::post('/authorize-user', [MembersController::class, 'authorizeUser']);
    Route::post('/members/{member}/deactivate', [MembersController::class, 'deactivate']);
    Route::post('/members/{member}/activate', [MembersController::class, 'activate']);
    Route::delete('/members/{id}/delete-both', [MembersController::class, 'deleteBoth']);
    Route::get('/members/by-user/{user}', [MembersController::class, 'byUser']);
    // Attendance
    Route::middleware('auth:sanctum')->group(function () {
        Route::get('/attendance', [AttendanceController::class, 'index']);
        Route::post('/attendance', [AttendanceController::class, 'store']);
        Route::get('/attendance/{serviceId}', [AttendanceController::class, 'show']);
    });

    // services
    Route::middleware('auth:sanctum')->group(function () {
        Route::post('/services', [ServiceController::class, 'store']);
    });

    // Guests
    Route::get('/guests/stats', [GuestsController::class, 'stats']);
    Route::apiResource('guests', GuestsController::class);

    // Groups
    Route::get('/groups/filter', [GroupsController::class, 'filterByZone']);
    Route::apiResource('groups', GroupsController::class);
    Route::get('/groups/{id}/members', [GroupsController::class, 'members']);
    Route::post('/groups/{group}/assign-leader', [GroupsController::class, 'assignLeader']);
    Route::get('/groups/{id}/members/search', [GroupsController::class, 'searchGroupMembers']);

    // Leaders
    Route::get('/leaders', [LeaderController::class, 'index']);
    Route::post('/leaders', [LeaderController::class, 'store']);
    Route::delete('/leaders/{id}', [LeaderController::class, 'destroy']);
    Route::get('/retired-leaders', [LeaderController::class, 'retired']);
    Route::post('/leaders/{id}/restore', [LeaderController::class, 'restore']);
    Route::post('/leaders/{id}/retire', [LeaderController::class, 'retire']);
    Route::post('/leaders/{id}/update-role', [LeaderController::class, 'updateRole']);
    Route::post('/leaders/{id}/retire', [LeaderController::class, 'retire']);

    // Leadership Roles
    Route::get('/leadership-roles', [LeadershipRoleController::class, 'index']);
    Route::post('/leadership-roles', [LeadershipRoleController::class, 'store']);
    Route::post('/assign-leadership-role', [MembersController::class, 'assignLeadershipRole']);
    Route::get('/user-role-assignments', [UserRoleController::class, 'index']);
    Route::put('/leadership-roles/{id}', [LeadershipRoleController::class, 'update']);
    Route::delete('/leadership-roles/{id}', [LeadershipRoleController::class, 'destroy']);
    Route::put('/{id}/roles', [LeaderController::class, 'updateRole']);
    // Update all leader details + roles
    Route::put('/leaders/{id}', [LeaderController::class, 'update']);

    // Update only roles
    Route::put('/leaders/{id}/roles', [LeaderController::class, 'updateRole']);

    // Events
    Route::get('/events/past', [EventController::class, 'pastEvents']);
    Route::apiResource('events', EventController::class);

    // Service Events
    Route::apiResource('service-events', ServiceEventController::class);

    // Children
    Route::apiResource('children', ChildrenController::class);

    // Contributions
    Route::get('/contributions', [ContributionController::class, 'index']);
    Route::post('/contributions', [ContributionController::class, 'store']);
    Route::get('/contributions/{id}', [ContributionController::class, 'show']);
    Route::put('/contributions/{id}', [ContributionController::class, 'update']);
    Route::patch('/contributions/{id}', [ContributionController::class, 'update']);
    Route::delete('/contributions/{id}', [ContributionController::class, 'destroy']);
    Route::get('/contributors', [ContributionController::class, 'contributors']);

    // Contribution Types
    Route::apiResource('contribution-types', ContributionTypeController::class);

    // Assets
    Route::get('/assets', [AssetController::class, 'index']);
    Route::post('/assets', [AssetController::class, 'store']);
    Route::put('/assets/{asset}', [AssetController::class, 'update']);
    Route::delete('/assets/{asset}', [AssetController::class, 'destroy']);

    // SMS
    Route::post('/send-sms', [SMSController::class, 'send']);
    Route::get('/sms/logs', [SMSController::class, 'logs']);

    //  Gallery upload/delete
    Route::post('/gallery', [GalleryController::class, 'store']);
    Route::delete('/gallery/{id}', [GalleryController::class, 'destroy']);

    Route::get('/dashboard-verse', [UserSettingsController::class, 'getVerse']);
    Route::post('/dashboard-verse', [UserSettingsController::class, 'saveVerse']);
});

// Leader group actions
Route::middleware(['auth:sanctum'])->group(function () {
    Route::post('/groups/{group}/add-member', [GroupsController::class, 'addMember']);
    Route::post('/groups/{group}/remove-member', [GroupsController::class, 'removeMember']);
});

// Test env
Route::get('/test-env', function () {
    return response()->json([
        'api_key' => config('services.beem.api_key'),
        'secret' => config('services.beem.secret'),
        'sender' => config('services.beem.sender'),
    ]);
});

Route::get('/server-ip', function () {
    return response()->json([
        'server_ip' => request()->server('SERVER_ADDR'),
        'client_ip' => request()->ip(),
    ]);
});
