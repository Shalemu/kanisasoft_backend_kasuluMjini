<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Guest;
use Illuminate\Support\Facades\Validator;

class GuestsController extends Controller
{
    // Get all guests
    public function index(Request $request)
    {
        $query = Guest::query();

        $selectedDate = $request->input('date', $request->input('filter_date'));
        if (filled($selectedDate)) {
            $query->whereDate('visit_date', $selectedDate);
        }

        if ($request->filled('from_date')) {
            $query->whereDate('visit_date', '>=', $request->from_date);
        }

        if ($request->filled('to_date')) {
            $query->whereDate('visit_date', '<=', $request->to_date);
        }

        if ($request->filled('search')) {
            $search = $request->search;

            $query->where(function ($q) use ($search) {
                $q->where('full_name', 'like', "%{$search}%")
                    ->orWhere('phone', 'like', "%{$search}%")
                    ->orWhere('church_origin', 'like', "%{$search}%")
                    ->orWhere('other', 'like', "%{$search}%");
            });
        }

        $summaryQuery = clone $query;
        $guests = $query->latest()->get();

        return response()->json([
            'status' => 'success',
            'summary' => [
                'total_guests' => (clone $summaryQuery)->count(),
                'total_prayer' => (clone $summaryQuery)->where('prayer', true)->count(),
                'total_salvation' => (clone $summaryQuery)->where('salvation', true)->count(),
                'total_joining' => (clone $summaryQuery)->where('joining', true)->count(),
                'total_travel' => (clone $summaryQuery)->where('travel', true)->count(),
            ],
            'guests' => $guests
        ]);
    }

    public function stats(Request $request)
    {
        $query = Guest::query();

        $selectedDate = $request->input('date', $request->input('filter_date'));
        if (filled($selectedDate)) {
            $query->whereDate('visit_date', $selectedDate);
        }

        return response()->json([
            'status' => 'success',
            'total_guests' => (clone $query)->count(),
            'total_prayer' => (clone $query)->where('prayer', true)->count(),
            'total_salvation' => (clone $query)->where('salvation', true)->count(),
            'total_joining' => (clone $query)->where('joining', true)->count(),
            'total_travel' => (clone $query)->where('travel', true)->count(),
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
