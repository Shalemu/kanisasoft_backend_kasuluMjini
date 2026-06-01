<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;

class AdminController extends Controller
{
    public function assignRole(Request $request)
    {
        $request->validate([
            'user_id' => 'required|exists:users,id',
            'role' => 'required|string|in:admin,katibu,hazina,mchungaji,kiongozi,mshirika',
        ]);

        $admin = $request->user();
        if ($admin->role !== 'admin') {
            return response()->json(['message' => 'Unauthorized'], 403);
        }

        $user = User::findOrFail($request->user_id);
        $user->role = $request->role;
        $user->save();

        return response()->json(['message' => 'Role assigned successfully', 'user' => $user]);
    }
}
