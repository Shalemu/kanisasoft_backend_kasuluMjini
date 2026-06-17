<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Billing;
use Illuminate\Http\Request;

class BillingController extends Controller
{
    /**
     * List all billing records.
     */
    public function index()
    {
        $billings = Billing::with('creator:id,full_name')
            ->latest()
            ->get()
            ->map(fn ($item) => $this->formatBilling($item));

        return response()->json($billings);
    }

    /**
     * Store a new billing record.
     */
    public function store(Request $request)
    {
        $validated = $request->validate([
            'invoice_number' => 'required|string|max:255',
            'invoice_date'   => 'required|date',
            'due_date'       => 'nullable|date',
            'total'          => 'required|numeric|min:0',
            'payment_method' => 'nullable|string|max:255',
            'transaction_id' => 'nullable|string|max:255',
            'gateway'        => 'nullable|string|max:255',
            'status'         => 'nullable|string|in:paid,unpaid,overdue,Lipiwa,Halijalipiwa,Imechelewa',
            'notes'          => 'nullable|string',
        ]);

        $validated['created_by'] = auth()->id();
        $validated['status'] = $this->normalizeStatus($validated['status'] ?? 'unpaid');

        $billing = Billing::create($validated);
        $billing->load('creator:id,full_name');

        return response()->json([
            'message' => 'Malipo ya ankara yamerekodiwa.',
            'data' => $this->formatBilling($billing),
        ], 201);
    }

    /**
     * View a single billing record.
     */
    public function show($id)
    {
        $billing = Billing::with('creator:id,full_name')->find($id);

        if (! $billing) {
            return response()->json([
                'message' => 'Malipo ya ankara hayapo.',
            ], 404);
        }

        return response()->json($this->formatBilling($billing));
    }

    /**
     * Update a billing record.
     */
    public function update(Request $request, $id)
    {
        $billing = Billing::find($id);

        if (! $billing) {
            return response()->json([
                'message' => 'Malipo ya ankara hayapo.',
            ], 404);
        }

        $validated = $request->validate([
            'invoice_number' => 'sometimes|required|string|max:255',
            'invoice_date'   => 'nullable|date',
            'due_date'       => 'nullable|date',
            'total'          => 'nullable|numeric|min:0',
            'payment_method' => 'nullable|string|max:255',
            'transaction_id' => 'nullable|string|max:255',
            'gateway'        => 'nullable|string|max:255',
            'status'         => 'nullable|string|in:paid,unpaid,overdue,Lipiwa,Halijalipiwa,Imechelewa',
            'notes'          => 'nullable|string',
        ]);

        // Normalize Swahili status to English
        if (isset($validated['status'])) {
            $validated['status'] = $this->normalizeStatus($validated['status']);
        }

        $billing->update($validated);
    
        return response()->json([
            'message' => 'Malipo ya ankara yamesasishwa.',
            'data' => $this->formatBilling($billing->fresh(['creator:id,full_name'])),
        ]);
    }

    /**
     * Delete a billing record.
     */
    public function destroy($id)
    {
        $billing = Billing::find($id);

        if (! $billing) {
            return response()->json([
                'message' => 'Malipo ya ankara hayapo.',
            ], 404);
        }

        $billing->delete();

        return response()->json([
            'message' => 'Malipo ya ankara yamefutwa.',
        ]);
    }

    /**
     * Normalize Swahili status to English.
     */
    private function normalizeStatus(string $status): string
    {
        return match ($status) {
            'Lipiwa'        => 'paid',
            'Halijalipiwa'  => 'unpaid',
            'Imechelewa'    => 'overdue',
            default         => $status,
        };
    }

    /**
     * Format a billing record for API response.
     */
    private function formatBilling(Billing $item): array
    {
        return [
            'id'              => $item->id,
            'invoice_number'  => $item->invoice_number,
            'invoice_date'    => optional($item->invoice_date)->format('Y-m-d'),
            'due_date'        => optional($item->due_date)->format('Y-m-d'),
            'total'           => (float) $item->total,
            'payment_method'  => $item->payment_method,
            'transaction_id'  => $item->transaction_id,
            'gateway'         => $item->gateway,
            'status'          => $item->status ?? 'unpaid',
            'notes'           => $item->notes,
            'created_by'      => $item->created_by,
            'created_by_name' => $item->creator?->full_name,
            'created_at'      => $item->created_at,
            'updated_at'      => $item->updated_at,
        ];
    }
}
