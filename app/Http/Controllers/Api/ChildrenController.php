<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Child;
use Illuminate\Http\Request;

class ChildrenController extends Controller
{
    public function index()
    {
        return response()->json([
            'status' => 'success',
            'children' => Child::latest()->get(),
        ]);
    }

    public function store(Request $request)
    {
        $request->merge([
            'gender' => match ($request->gender) {
                'Mwanaume' => 'M',
                'Mwanamke' => 'F',
                default => $request->gender,
            },
        ]);

        $request->validate([
            'child_name' => 'required|string|max:255',
            'birth_date' => 'nullable|date',
            'gender' => 'required|in:M,F',
            'parent_name' => 'nullable|string|max:255',
            'relationship' => 'nullable|string|max:255',
            'phone' => 'nullable|string|max:20',
        ]);

        try {
            $child = Child::create($request->only([
                'child_name', 'birth_date', 'gender',
                'parent_name', 'relationship', 'phone',
            ]));

            return response()->json([
                'status' => 'success',
                'message' => 'Mtoto amesajiliwa kikamilifu!',
                'child' => $child,
            ], 201);
        } catch (\Throwable $e) {
            return response()->json([
                'status' => 'error',
                'message' => 'Server Error: ' . $e->getMessage(),
            ], 500);
        }
    }

    public function show(Child $child)
    {
        return response()->json([
            'status' => 'success',
            'child' => $child,
        ]);
    }

    public function update(Request $request, Child $child)
    {
        $request->merge([
            'gender' => match ($request->gender) {
                'Mwanaume' => 'M',
                'Mwanamke' => 'F',
                default => $request->gender,
            },
        ]);

        $request->validate([
            'child_name' => 'sometimes|required|string|max:255',
            'birth_date' => 'nullable|date',
            'gender' => 'sometimes|required|in:M,F',
            'parent_name' => 'nullable|string|max:255',
            'relationship' => 'nullable|string|max:255',
            'phone' => 'nullable|string|max:20',
        ]);

        try {
            $child->update($request->only([
                'child_name', 'birth_date', 'gender',
                'parent_name', 'relationship', 'phone',
            ]));

            return response()->json([
                'status' => 'success',
                'message' => 'Taarifa za mtoto zimesasishwa!',
                'child' => $child->fresh(),
            ]);
        } catch (\Throwable $e) {
            return response()->json([
                'status' => 'error',
                'message' => 'Server Error: ' . $e->getMessage(),
            ], 500);
        }
    }

    public function destroy(Child $child)
    {
        try {
            $child->delete();

            return response()->json([
                'status' => 'success',
                'message' => 'Mtoto amefutwa!',
            ]);
        } catch (\Throwable $e) {
            return response()->json([
                'status' => 'error',
                'message' => 'Server Error: ' . $e->getMessage(),
            ], 500);
        }
    }
}
