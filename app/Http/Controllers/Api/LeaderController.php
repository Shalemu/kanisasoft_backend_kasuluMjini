<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Leader;
use App\Models\User;
use Illuminate\Support\Facades\Validator;

class LeaderController extends Controller
{
    /**
     * List active leaders
     */
    public function index()
    {
        $leaders = Leader::with(['user', 'roles'])
            ->where('status', 'active')
            ->latest()
            ->get();

        $formatted = $leaders->map(fn ($leader) => [
            'id'      => $leader->id,
            'user_id' => $leader->user_id,
            'name'    => $leader->user->full_name ?? $leader->full_name,
            'email'   => $leader->user->email ?? $leader->email,
            'phone'   => $leader->user->phone ?? $leader->phone,
            'roles'   => $leader->roles->pluck('title'),
            'status'  => $leader->status,
        ]);

        return response()->json([
            'status'  => 'success',
            'leaders' => $formatted,
        ]);
    }

    /**
     * Assign leader with roles
     * IMPORTANT: This does NOT modify users.role
     */
    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'user_id'    => 'required|exists:users,id',
            'role_ids'   => 'required|array|min:1',
            'role_ids.*' => 'exists:leadership_roles,id',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status'  => 'error',
                'message' => $validator->errors()->first(),
            ], 422);
        }

        $user = User::findOrFail($request->user_id);

        // Prevent duplicate leader per user
        $leader = Leader::firstOrCreate(
            ['user_id' => $user->id],
            [
                'leader_code' => 'LEAD-' . uniqid(),
                'full_name'   => $user->full_name,
                'phone'       => $user->phone,
                'email'       => $user->email,
                'status'      => 'active',
            ]
        );

        // Attach roles (no duplicates)
        $leader->roles()->syncWithoutDetaching($request->role_ids);

        return response()->json([
            'status'  => 'success',
            'message' => 'Kiongozi ameongezwa kwa mafanikio.',
            'leader'  => $leader->load('roles'),
        ], 201);
    }

    /**
     * Update leader roles only
     */
    public function updateRole(Request $request, $id)
    {
        $leader = Leader::findOrFail($id);

        $validated = $request->validate([
            'role_ids'   => 'required|array|min:1',
            'role_ids.*' => 'exists:leadership_roles,id',
        ]);

        $leader->roles()->sync($validated['role_ids']);

        return response()->json([
            'status'  => 'success',
            'message' => 'Nafasi za kiongozi zimesasishwa kikamilifu.',
            'leader'  => $leader->load('roles'),
        ]);
    }

    /**
     * Update leader details and roles
     * IMPORTANT: users.role is NEVER changed here
     */
    public function update(Request $request, $id)
    {
        $leader = Leader::findOrFail($id);

        $validator = Validator::make($request->all(), [
            'user_id'    => 'nullable|exists:users,id',
            'full_name'  => 'required_without:user_id|string|max:255',
            'phone'      => 'required_without:user_id|string|max:20',
            'email'      => 'nullable|email|max:255',
            'role_ids'   => 'required|array|min:1',
            'role_ids.*' => 'exists:leadership_roles,id',
            'status'     => 'nullable|in:active,retired',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status'  => 'error',
                'message' => $validator->errors()->first(),
            ], 422);
        }

        $data = $validator->validated();

        // Assign user if provided
        if (!empty($data['user_id'])) {
            $user = User::findOrFail($data['user_id']);

            // Prevent duplicate leader assignment
            $exists = Leader::where('user_id', $user->id)
                ->where('id', '!=', $leader->id)
                ->exists();

            if ($exists) {
                return response()->json([
                    'status'  => 'error',
                    'message' => 'User is already assigned as a leader.',
                ], 422);
            }

            $leader->update([
                'user_id'   => $user->id,
                'full_name' => $user->full_name,
                'phone'     => $user->phone,
                'email'     => $user->email,
                'status'    => $data['status'] ?? $leader->status,
            ]);
        } else {
            // Independent leader (no user)
            $leader->update([
                'user_id'   => null,
                'full_name' => $data['full_name'],
                'phone'     => $data['phone'],
                'email'     => $data['email'] ?? $leader->email,
                'status'    => $data['status'] ?? $leader->status,
            ]);
        }

        // Sync leadership roles
        $leader->roles()->sync($data['role_ids']);

        return response()->json([
            'status'  => 'success',
            'message' => 'Kiongozi amesahihishwa kikamilifu.',
            'leader'  => $leader->load('roles'),
        ]);
    }

    /**
     * Remove leader
     * IMPORTANT: users.role is NOT modified
     */
    public function destroy($id)
    {
        $leader = Leader::findOrFail($id);

        $leader->roles()->detach();
        $leader->delete();

        return response()->json([
            'status'  => 'success',
            'message' => 'Leader deleted successfully.',
        ]);
    }
}
