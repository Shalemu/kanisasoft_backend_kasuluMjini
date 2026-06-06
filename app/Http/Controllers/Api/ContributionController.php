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
    public function index(Request $request)
    {
        $request->validate([
            'from_date' => 'nullable|date',
            'to_date' => 'nullable|date|after_or_equal:from_date',
            'date_from' => 'nullable|date',
            'date_to' => 'nullable|date|after_or_equal:date_from',
            'type' => 'nullable|string|max:255',
            'method' => 'nullable|string|max:255',
            'user_id' => 'nullable|exists:users,id',
            'search' => 'nullable|string|max:255',
        ]);

        $query = $this->filteredQuery($request)->with('user');
        $summaryQuery = clone $query;
        $contributions = $query->latest('date')->latest('id')->get();
        $totalAmount = (float) (clone $summaryQuery)->sum('amount');

        return response()->json([
            'status' => 'success',
            'summary' => [
                'total_contributions' => $totalAmount,
                'total_amount' => $totalAmount,
                'total_records' => $contributions->count(),
                'by_type' => $contributions->groupBy('type')->map(fn ($items) => [
                    'count' => $items->count(),
                    'total' => (float) $items->sum('amount'),
                ]),
                'by_method' => $contributions->groupBy('method')->map(fn ($items) => [
                    'count' => $items->count(),
                    'total' => (float) $items->sum('amount'),
                ]),
            ],
            'filters' => $request->only([
                'from_date', 'to_date', 'date_from', 'date_to', 'type', 'method', 'user_id', 'search',
            ]),
            'export' => [
                'columns' => ['date', 'type', 'amount', 'method', 'giver', 'user_id', 'giver_name'],
                'rows' => $contributions->map(fn ($c) => $this->formatContribution($c)),
            ],
            'reports' => $contributions->map(fn ($c) => $this->formatContribution($c)),
            'contributions' => $contributions->map(fn ($c) => $this->formatContribution($c)),
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
            'data' => $this->formatContribution($contribution),
            'contribution' => $this->formatContribution($contribution),
        ]);
        
    }

    public function show(int $id)
    {
        $contribution = Contribution::with('user')->find($id);

        if (! $contribution) {
            return response()->json([
                'status' => 'error',
                'message' => 'Mchango haukupatikana.',
            ], 404);
        }

        return response()->json([
            'status' => 'success',
            'contribution' => $this->formatContribution($contribution),
            'edit_data' => $this->formatContribution($contribution),
        ]);
    }

    public function update(Request $request, int $id)
    {
        $contribution = Contribution::find($id);

        if (! $contribution) {
            return response()->json([
                'status' => 'error',
                'message' => 'Mchango haukupatikana.',
            ], 404);
        }

        $validated = $request->validate([
            'date' => 'sometimes|required|date',
            'type' => 'sometimes|required|string|max:255',
            'amount' => 'sometimes|required|numeric|min:0',
            'method' => 'sometimes|required|string|max:255',
            'user_id' => 'nullable|exists:users,id',
            'giver_name' => 'nullable|string|max:255',
        ]);

        $userId = Arr::get($validated, 'user_id', $contribution->user_id);
        $giverName = Arr::get($validated, 'giver_name', $contribution->giver_name);
        if (empty($userId) && empty($giverName)) {
            return response()->json([
                'status' => 'error',
                'message' => 'Tafadhali chagua mshirika au andika jina la mtoaji.',
            ], 422);
        }

        $contribution->update($validated);
        $contribution = $contribution->fresh(['user']);

        return response()->json([
            'status' => 'success',
            'message' => 'Mchango umesasishwa vizuri.',
            'contribution' => $this->formatContribution($contribution),
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

    private function filteredQuery(Request $request)
    {
        $query = Contribution::query();

        $fromDate = $request->input('from_date', $request->input('date_from'));
        $toDate = $request->input('to_date', $request->input('date_to'));

        if (filled($fromDate)) {
            $query->whereDate('date', '>=', $fromDate);
        }

        if (filled($toDate)) {
            $query->whereDate('date', '<=', $toDate);
        }

        foreach (['type', 'method', 'user_id'] as $field) {
            if ($request->filled($field)) {
                $query->where($field, $request->input($field));
            }
        }

        if ($request->filled('search')) {
            $search = $request->search;
            $query->where(function ($query) use ($search) {
                $query->where('giver_name', 'like', "%{$search}%")
                    ->orWhereHas('user', fn ($userQuery) => $userQuery->where('full_name', 'like', "%{$search}%"));
            });
        }

        return $query;
    }

    private function formatContribution(Contribution $contribution): array
    {
        return [
            'id' => $contribution->id,
            'user_id' => $contribution->user_id,
            'giver_name' => $contribution->giver_name,
            'date' => optional($contribution->date)->format('Y-m-d'),
            'type' => $contribution->type,
            'amount' => (float) $contribution->amount,
            'method' => $contribution->method,
            'giver' => $contribution->user?->full_name ?? $contribution->giver_name,
            'created_at' => optional($contribution->created_at)->toISOString(),
            'updated_at' => optional($contribution->updated_at)->toISOString(),
        ];
    }
}
