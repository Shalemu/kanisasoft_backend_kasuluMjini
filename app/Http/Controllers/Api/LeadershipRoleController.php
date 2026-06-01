<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\LeadershipRole;

class LeadershipRoleController extends Controller
{
    /**
     * List all leadership roles
     */
    public function index()
    {
        return response()->json([
            'status' => 'success',
            'roles' => LeadershipRole::all(),
        ]);
    }

    /**
     * Create a new role
     */
    public function store(Request $request)
    {
        $request->validate([
            'title' => 'required|string|max:255|unique:leadership_roles,title',
        ]);

        $role = LeadershipRole::create([
            'title' => $request->title,
            'protected' => false, // default
        ]);

        return response()->json([
            'status' => 'success',
            'message' => 'Nafasi imeongezwa kikamilifu.',
            'role' => $role,
        ]);
    }

    /**
     * Update an existing role
     */
    public function update(Request $request, $id)
    {
        $role = LeadershipRole::findOrFail($id);

        if ($role->protected && $request->title !== $role->title) {
            return response()->json([
                'status' => 'error',
                'message' => 'Huwezi kubadilisha jina la nafasi iliyo lindwa.',
            ], 403);
        }

        $request->validate([
            'title' => 'required|string|max:255|unique:leadership_roles,title,' . $role->id,
        ]);

        $role->update([
            'title' => $request->title,
        ]);

        return response()->json([
            'status' => 'success',
            'message' => 'Nafasi imesasishwa kikamilifu.',
            'role' => $role,
        ]);
    }

    /**
     * Delete a role
     */
    public function destroy($id)
    {
        $role = LeadershipRole::findOrFail($id);

        if ($role->protected) {
            return response()->json([
                'status' => 'error',
                'message' => 'Hii nafasi ni ya msingi na haiwezi kufutwa.',
            ], 403);
        }

        $role->delete();

        return response()->json([
            'status' => 'success',
            'message' => 'Nafasi imefutwa kikamilifu.',
        ]);
    }
}
