<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Contribution;
use Illuminate\Http\Request;

class ContributionController extends Controller
{
    /**
     * Display a list of all contributions.
     */
    public function index(Request $request)
    {
        $request->validate([
            'start_date' => 'nullable|date',
            'end_date' => 'nullable|date|after_or_equal:start_date',
            'from_date' => 'nullable|date',
            'to_date' => 'nullable|date|after_or_equal:from_date',
            'date_from' => 'nullable|date',
            'date_to' => 'nullable|date|after_or_equal:date_from',
            'type' => 'nullable|string|max:255',
            'category' => 'nullable|string|max:255',
            'method' => 'nullable|string|max:255',
            'payment_method' => 'nullable|string|max:255',
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
                'start_date', 'end_date', 'from_date', 'to_date', 'date_from', 'date_to',
                'type', 'category', 'method', 'payment_method', 'user_id', 'search',
            ]),
            'export' => [
                'columns' => [
                    'date', 'contribution_date', 'amount', 'type', 'category',
                    'payment_method', 'donor_name', 'reference', 'notes',
                ],
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
        $payload = $this->normalizeContributionPayload($request);

        $validated = validator($payload, [
            'date' => 'required|date',
            'type' => 'required|string|max:255',
            'amount' => 'required|numeric|gt:0',
            'method' => 'nullable|string|max:255',
            'user_id' => 'nullable|exists:users,id',
            'giver_name' => 'nullable|string|max:255',
            'reference' => 'nullable|string|max:255',
            'notes' => 'nullable|string',
        ])->validate();

        $validated['method'] = $validated['method'] ?? 'Cash';

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

        $payload = $this->normalizeContributionPayload($request);

        $validated = validator($payload, [
            'date' => 'sometimes|required|date',
            'type' => 'sometimes|required|string|max:255',
            'amount' => 'sometimes|required|numeric|gt:0',
            'method' => 'nullable|string|max:255',
            'user_id' => 'nullable|exists:users,id',
            'giver_name' => 'nullable|string|max:255',
            'reference' => 'nullable|string|max:255',
            'notes' => 'nullable|string',
        ])->validate();

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
            'message' => 'Contribution deleted successfully',
        ]);
    }

    private function filteredQuery(Request $request)
    {
        $query = Contribution::query();

        $fromDate = $request->input('start_date', $request->input('from_date', $request->input('date_from')));
        $toDate = $request->input('end_date', $request->input('to_date', $request->input('date_to')));

        if (filled($fromDate)) {
            $query->whereDate('date', '>=', $fromDate);
        }

        if (filled($toDate)) {
            $query->whereDate('date', '<=', $toDate);
        }

        $type = $request->input('type', $request->input('category'));
        if (filled($type)) {
            $query->where('type', $type);
        }

        $method = $request->input('payment_method', $request->input('method'));
        if (filled($method)) {
            $query->where('method', $method);
        }

        if ($request->filled('user_id')) {
            $query->where('user_id', $request->input('user_id'));
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

    private function normalizeContributionPayload(Request $request): array
    {
        $data = $request->all();

        if ($request->has('date') || $request->has('contribution_date')) {
            $data['date'] = $request->input('date', $request->input('contribution_date'));
        }

        if ($request->has('type') || $request->has('category')) {
            $data['type'] = $request->input('type', $request->input('category'));
        }

        if ($request->has('payment_method') || $request->has('method')) {
            $data['method'] = $request->input('payment_method', $request->input('method'));
        }

        if ($request->has('donor_name') || $request->has('giver_name')) {
            $data['giver_name'] = $request->input('donor_name', $request->input('giver_name'));
        }

        return $data;
    }

    private function formatContribution(Contribution $contribution): array
    {
        $date = optional($contribution->date)->format('Y-m-d');
        $donorName = $contribution->user?->full_name ?? $contribution->giver_name;

        return [
            'id' => $contribution->id,
            'user_id' => $contribution->user_id,
            'giver_name' => $contribution->giver_name,
            'donor_name' => $donorName,
            'date' => $date,
            'contribution_date' => $date,
            'type' => $contribution->type,
            'category' => $contribution->type,
            'amount' => (float) $contribution->amount,
            'method' => $contribution->method,
            'payment_method' => $contribution->method,
            'reference' => $contribution->reference,
            'notes' => $contribution->notes,
            'giver' => $donorName,
            'created_at' => optional($contribution->created_at)->toISOString(),
            'updated_at' => optional($contribution->updated_at)->toISOString(),
        ];
    }
}
