<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Zaka;
use Illuminate\Http\Request;

class ZakaController extends Controller
{
    /**
     * List all zaka with optional date filtering.
     */
    public function index(Request $request)
    {
        $request->validate([
            'start_date' => 'nullable|date',
            'end_date' => 'nullable|date|after_or_equal:start_date',
        ]);

        $query = Zaka::query();

        if ($request->filled('start_date')) {
            $query->whereDate('date', '>=', $request->start_date);
        }

        if ($request->filled('end_date')) {
            $query->whereDate('date', '<=', $request->end_date);
        }

        $zaka = $query->latest('date')->latest('id')->get();

        return response()->json($zaka);
    }

    /**
     * Store new zaka record.
     */
    public function store(Request $request)
    {
        $validated = $request->validate([
            'date' => 'required|date',
            'member_id' => 'nullable|exists:users,id',
            'member_name' => 'nullable|string|max:255',
            'membership_number' => 'nullable|string|max:100',
            'amount' => 'required|numeric|min:0',
        ]);

        $validated['created_by'] = auth()->id();

        $zaka = Zaka::create($validated);

        return response()->json([
            'message' => 'Zaka imehifadhiwa.',
            'data' => $zaka,
        ], 201);
    }

    /**
     * Update zaka record.
     */
    public function update(Request $request, $id)
    {
        $zaka = Zaka::find($id);

        if (! $zaka) {
            return response()->json([
                'message' => 'Zaka haipo.',
            ], 404);
        }

        $validated = $request->validate([
            'date' => 'sometimes|required|date',
            'member_id' => 'nullable|exists:users,id',
            'member_name' => 'nullable|string|max:255',
            'membership_number' => 'nullable|string|max:100',
            'amount' => 'sometimes|required|numeric|min:0',
        ]);

        $zaka->update($validated);

        return response()->json([
            'message' => 'Zaka imesasishwa.',
            'data' => $zaka,
        ]);
    }

    /**
     * Delete zaka record.
     */
    public function destroy($id)
    {
        $zaka = Zaka::find($id);

        if (! $zaka) {
            return response()->json([
                'message' => 'Zaka haipo.',
            ], 404);
        }

        $zaka->delete();

        return response()->json([
            'message' => 'Zaka imefutwa.',
        ]);
    }
}
