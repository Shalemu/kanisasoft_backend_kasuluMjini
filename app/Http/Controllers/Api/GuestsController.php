<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Guest;
use Illuminate\Support\Facades\Validator;

class GuestsController extends Controller
{
    // Get all guests
    public function index()
    {
        $guests = Guest::latest()->get();

        return response()->json([
            'status' => 'success',
            'guests' => $guests
        ]);
    }

    // Create a new guest
    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'full_name'      => 'required|string|max:255',
            'phone'          => 'nullable|string|max:20',
            'church_origin'  => 'required|string|max:255',
            'visit_date'     => 'nullable|date',
            'prayer'         => 'boolean',
            'salvation'      => 'boolean',
            'joining'        => 'boolean',
            'travel'         => 'boolean',
            'other'          => 'nullable|string|max:255',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => 'error',
                'errors' => $validator->errors(),
            ], 422);
        }

        $guest = Guest::create([
            'full_name'     => $request->full_name,
            'phone'         => $request->phone,
            'church_origin' => $request->church_origin,
            'visit_date'    => $request->visit_date ?? now()->toDateString(), 
            'prayer'        => $request->prayer ?? false,
            'salvation'     => $request->salvation ?? false,
            'joining'       => $request->joining ?? false,
            'travel'        => $request->travel ?? false,
            'other'         => $request->other,
        ]);

        return response()->json([
            'status' => 'success',
            'message' => 'Mgeni ameongezwa kikamilifu',
            'guest' => $guest
        ], 201);
    }

    // Show a specific guest
    public function show($id)
    {
        $guest = Guest::find($id);

        if (!$guest) {
            return response()->json([
                'status' => 'error',
                'message' => 'Mgeni hakupatikana'
            ], 404);
        }

        return response()->json([
            'status' => 'success',
            'guest' => $guest
        ]);
    }

    // Update a guest
    public function update(Request $request, $id)
    {
        $guest = Guest::find($id);

        if (!$guest) {
            return response()->json([
                'status' => 'error',
                'message' => 'Mgeni hakupatikana'
            ], 404);
        }

        $validator = Validator::make($request->all(), [
            'full_name'      => 'sometimes|required|string|max:255',
            'phone'          => 'nullable|string|max:20',
            'church_origin'  => 'sometimes|required|string|max:255',
            'visit_date'     => 'nullable|date',
            'prayer'         => 'boolean',
            'salvation'      => 'boolean',
            'joining'        => 'boolean',
            'travel'         => 'boolean',
            'other'          => 'nullable|string|max:255',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => 'error',
                'errors' => $validator->errors(),
            ], 422);
        }

        $guest->update([
            'full_name'     => $request->full_name ?? $guest->full_name,
            'phone'         => $request->phone ?? $guest->phone,
            'church_origin' => $request->church_origin ?? $guest->church_origin,
            'visit_date'    => $request->visit_date ?? $guest->visit_date,
            'prayer'        => $request->prayer ?? $guest->prayer,
            'salvation'     => $request->salvation ?? $guest->salvation,
            'joining'       => $request->joining ?? $guest->joining,
            'travel'        => $request->travel ?? $guest->travel,
            'other'         => $request->other ?? $guest->other,
        ]);

        return response()->json([
            'status' => 'success',
            'message' => 'Taarifa za mgeni zimesasishwa',
            'guest' => $guest
        ]);
    }

    // Delete a guest
    public function destroy($id)
    {
        $guest = Guest::find($id);

        if (!$guest) {
            return response()->json([
                'status' => 'error',
                'message' => 'Mgeni hakupatikana'
            ], 404);
        }

        $guest->delete();

        return response()->json([
            'status' => 'success',
            'message' => 'Mgeni amefutwa kikamilifu'
        ]);
    }
}
