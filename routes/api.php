<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\{
    AuthController,
    MembersController,
    GuestsController,
    GroupsController,
    AdminController,
    LeaderController,
    LeadershipRoleController,
    EventController,
    ContributionController,
    ContributionTypeController,
    AssetController,
    SMSController,
    GalleryController,
    UserSettingsController,
    UserRoleController,
    ServiceEventController,
    ChildrenController,
};

// Public routes
Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);
Route::post('/change-password', [AuthController::class, 'changePassword'])->middleware('auth:sanctum');
Route::post('/forgot-password', [AuthController::class, 'forgotPassword']);
Route::post('/reset-password', [AuthController::class, 'resetPassword']);
Route::middleware('auth:sanctum')->post('/users/assign-roles', [UserRoleController::class, 'assignRoles']);



//  Public access to gallery
Route::get('/gallery', [GalleryController::class, 'index']);

// Protected routes
Route::middleware('auth:sanctum')->group(function () {
    // Auth
    Route::post('/logout', [AuthController::class, 'logout']);
    Route::get('/mtumiaji/profile', [AuthController::class, 'me']);
    Route::get('/mtumiaji', fn(Request $request) => $request->user());
    Route::post('/user/update-profile', [AuthController::class, 'updateProfile']);
    Route::get('/users', [AuthController::class, 'allUsers']);
    // Reject a user (mark as rejected instead of deleting)
   Route::post('/users/{id}/reject', [AuthController::class, 'rejectUser']);

    // Members
    Route::apiResource('members', MembersController::class);
    Route::post('/authorize-user', [MembersController::class, 'authorizeUser']);
    Route::post('/members/{member}/deactivate', [MembersController::class, 'deactivate']);
    Route::post('/members/{member}/activate', [MembersController::class, 'activate']);
    Route::delete('/members/{id}/delete-both', [MembersController::class, 'deleteBoth']);
    Route::get('/members/by-user/{user}', [MembersController::class, 'byUser']);
    Route::middleware(['auth:sanctum'])->group(function () {
    Route::get('/members/stats', [MembersController::class, 'stats']);
});




    // Guests
    Route::apiResource('guests', GuestsController::class);

    // Groups
    Route::apiResource('groups', GroupsController::class);
    Route::get('/groups/{id}/members', [GroupsController::class, 'members']);
    Route::post('/groups/{group}/assign-leader', [GroupsController::class, 'assignLeader']);
    Route::get('/groups/filter', [GroupsController::class, 'filterByZone']);
    Route::get('/groups/{id}/members/search', [GroupsController::class, 'searchGroupMembers']);

    // Leaders
    Route::get('/leaders', [LeaderController::class, 'index']);
    Route::post('/leaders', [LeaderController::class, 'store']);
    Route::delete('/leaders/{id}', [LeaderController::class, 'destroy']);
    Route::get('/retired-leaders', [LeaderController::class, 'retired']);
    Route::post('/leaders/{id}/restore', [LeaderController::class, 'restore']);
    Route::post('/leaders/{id}/retire', [LeaderController::class, 'retire']);
    Route::post('/leaders/{id}/update-role', [LeaderController::class, 'updateRole']);

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
    Route::apiResource('events', EventController::class);

    // Service Events
    Route::apiResource('service-events', ServiceEventController::class);

    // Children
    Route::apiResource('children', ChildrenController::class);

    // Contributions
    Route::get('/contributions', [ContributionController::class, 'index']);
    Route::post('/contributions', [ContributionController::class, 'store']);
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


