<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\User;
use App\Models\Leader;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use App\Models\LeadershipRole;

class UserRoleController extends Controller
{
    /**
     * Return all user-leader-role assignments
     */
    public function index(): JsonResponse
    {
        $users = User::with('leaders.roles')->get();

        $assignments = $users->flatMap(function ($user) {
            return $user->leaders->flatMap(function ($leader) use ($user) {
                return $leader->roles->map(function ($role) use ($user, $leader) {
                    return [
                        'user_id'     => $user->id,
                        'leader_id'   => $leader->id,
                        'role_id'     => $role->id,
                        'role_title'  => $role->title,
                        'leader_name' => $leader->full_name,
                        'status'      => $leader->status,
                    ];
                });
            });
        })->values();

        return response()->json([
            'status' => 'success',
            'assignments' => $assignments,
        ]);
    }

    /**
     * Assign multiple roles to a user (keeps existing roles)
     */
    public function assignRoles(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'user_id' => 'required|exists:users,id',
            'roles'   => 'required|array',
            'roles.*' => 'exists:leadership_roles,id',
        ]);

        $user = User::findOrFail($validated['user_id']);

        // Create a new leader record if user doesn't have one for this assignment
        $leader = Leader::create([
            'leader_code' => 'LEAD-' . uniqid(),
            'user_id'     => $user->id,
            'full_name'   => $user->full_name,
            'phone'       => $user->phone,
            'email'       => $user->email,
            'status'      => 'active',
        ]);

        // Sync roles (attach multiple positions)
        $leader->roles()->sync($validated['roles']);

        // Mark user as a system leader
        $user->update(['role' => 'kiongozi']);

        return response()->json([
            'status' => 'success',
            'message' => 'Roles assigned successfully',
            'leader' => $leader->load('roles'),
        ]);
    }

    public function update(Request $request, $id)
{
    $role = LeadershipRole::findOrFail($id);
    $request->validate([
        'title' => 'required|string|max:255',
    ]);

    $role->title = $request->title;
    $role->save();

    return response()->json([
        'status' => 'success',
        'role' => $role
    ]);
}

}
