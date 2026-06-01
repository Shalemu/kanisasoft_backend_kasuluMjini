<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Contribution;
use Illuminate\Http\Request;
use Illuminate\Support\Arr;

class ContributionController extends Controller
{
    /**
     * Display a list of all contributions.
     */
    public function index()
    {
        $contributions = Contribution::with('user')->latest()->get();

        return response()->json([
            'status' => 'success',
            'reports' => $contributions->map(function ($c) {
                return [
                    'id' => $c->id,
                    'user_id' => $c->user_id, // ✅ Add this line
                    'date' => $c->date,
                    'type' => $c->type,
                    'amount' => $c->amount,
                    'method' => $c->method,
                    'giver' => $c->user?->full_name ?? $c->giver_name,
                ];
            }),
        ]);
    }

    /**
     * Store a newly created contribution.
     */
    public function store(Request $request)
    {
        $validated = $request->validate([
            'date' => 'required|date',
            'type' => 'required|string|max:255',
            'amount' => 'required|numeric|min:0',
            'method' => 'required|string|max:255',
            'user_id' => 'nullable|exists:users,id',
            'giver_name' => 'nullable|string|max:255',
        ]);

        // ✅ Fix: avoid undefined array key
        if (empty(Arr::get($validated, 'user_id')) && empty(Arr::get($validated, 'giver_name'))) {
            return response()->json([
                'status' => 'error',
                'message' => 'Tafadhali chagua mshirika au andika jina la mtoaji.'
            ], 422);
        }

        $contribution = Contribution::create($validated)->fresh(['user']);

        return response()->json([
            'status' => 'success',
            'message' => 'Mchango umehifadhiwa vizuri.',
            'data' => [
                'id' => $contribution->id,
                'date' => $contribution->date,
                'type' => $contribution->type,
                'amount' => $contribution->amount,
                'method' => $contribution->method,
                'giver' => $contribution->user?->full_name ?? $contribution->giver_name,
            ],
        ]);
        
    }
  
    public function contributors()
    {
        $washirika = \App\Models\User::select('id', 'full_name')->get();
        $others = Contribution::whereNull('user_id')
            ->selectRaw('DISTINCT giver_name as full_name')
            ->get();
    
        return response()->json([
            'status' => 'success',
            'contributors' => $washirika->concat($others)
        ]);
    }

    public function destroy($id)
    {
        $contribution = Contribution::findOrFail($id);
        $contribution->delete();

        return response()->json([
            'status' => 'success',
            'message' => 'Mchango umefutwa vizuri.',
        ]);
    }

}
