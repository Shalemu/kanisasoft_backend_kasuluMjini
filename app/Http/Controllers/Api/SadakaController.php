<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Sadaka;
use Illuminate\Http\Request;

class SadakaController extends Controller
{
    /**
     * List all sadaka with optional date filtering.
     */
    public function index(Request $request)
    {
        $request->validate([
            'start_date' => 'nullable|date',
            'end_date' => 'nullable|date|after_or_equal:start_date',
        ]);

        $query = Sadaka::query();

        if ($request->filled('start_date')) {
            $query->whereDate('date', '>=', $request->start_date);
        }

        if ($request->filled('end_date')) {
            $query->whereDate('date', '<=', $request->end_date);
        }

        $sadaka = $query->latest('date')->latest('id')->get();

        return response()->json($sadaka);
    }

    /**
     * Store new sadaka record.
     */
    public function store(Request $request)
    {
        $validated = $request->validate([
            'date' => 'required|date',
            'service_name' => 'required|string|max:255',
            'amount' => 'required|numeric|min:0',
        ]);

        $validated['created_by'] = auth()->id();

        $sadaka = Sadaka::create($validated);

        return response()->json([
            'message' => 'Sadaka imehifadhiwa.',
            'data' => $sadaka,
        ], 201);
    }

    /**
     * Update sadaka record.
     */
    public function update(Request $request, $id)
    {
        $sadaka = Sadaka::find($id);

        if (! $sadaka) {
            return response()->json([
                'message' => 'Sadaka haipo.',
            ], 404);
        }

        $validated = $request->validate([
            'date' => 'sometimes|required|date',
            'service_name' => 'sometimes|required|string|max:255',
            'amount' => 'sometimes|required|numeric|min:0',
        ]);

        $sadaka->update($validated);

        return response()->json([
            'message' => 'Sadaka imesasishwa.',
            'data' => $sadaka,
        ]);
    }

    /**
     * Delete sadaka record.
     */
    public function destroy($id)
    {
        $sadaka = Sadaka::find($id);

        if (! $sadaka) {
            return response()->json([
                'message' => 'Sadaka haipo.',
            ], 404);
        }

        $sadaka->delete();

        return response()->json([
            'message' => 'Sadaka imefutwa.',
        ]);
    }
}
