<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Invoice;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class InvoiceController extends Controller
{
    /**
     * List all invoices.
     */
    public function index()
    {
        $invoices = Invoice::with('uploader:id,full_name')
            ->latest()
            ->get()
            ->map(fn ($item) => $this->formatInvoice($item));

        return response()->json($invoices);
    }

    /**
     * View a single invoice.
     */
    public function show($id)
    {
        $invoice = Invoice::with('uploader:id,full_name')->find($id);

        if (! $invoice) {
            return response()->json([
                'message' => 'Ankara haipo.',
            ], 404);
        }

        return response()->json($this->formatInvoice($invoice));
    }

    /**
     * Store a new invoice (PDF upload).
     */
    public function store(Request $request)
    {
        $data = $request->validate([
            'title'           => 'required|string|max:255',
            'invoice_number'  => 'nullable|string|max:255',
            'invoice_date'    => 'nullable|date',
            'due_date'        => 'nullable|date',
            'sub_total'       => 'nullable|numeric|min:0',
            'credit'          => 'nullable|numeric|min:0',
            'total'           => 'nullable|numeric|min:0',
            'status'          => 'nullable|string|in:paid,unpaid,overdue,Lipiwa,Halijalipiwa,Imechelewa',
            'transactions'    => 'nullable|array',
            'transactions.*.date'           => 'nullable|date',
            'transactions.*.gateway'        => 'nullable|string|max:255',
            'transactions.*.transaction_id' => 'nullable|string|max:255',
            'transactions.*.amount'         => 'nullable|numeric|min:0',
            'file'            => 'nullable|file|mimes:pdf|max:20480',
        ]);

        if ($request->hasFile('file')) {
            $file = $request->file('file');
            $data['file_path'] = $file->store('invoices', 'public');
            $data['file_type'] = $file->getMimeType();
        }

        unset($data['file']);

        $data['uploaded_by_id']   = auth()->id();
        $data['uploaded_by_role'] = auth()->user()->role ?? 'Admin';
        $data['status']           = $this->normalizeStatus($data['status'] ?? 'unpaid');

        $invoice = Invoice::create($data);
        $invoice->load('uploader:id,full_name');

        return response()->json([
            'message' => 'Ankara imehifadhiwa.',
            'data' => $this->formatInvoice($invoice),
        ], 201);
    }

    /**
     * Update an invoice (title only — file remains).
     */
    public function update(Request $request, $id)
    {
        $invoice = Invoice::find($id);

        if (! $invoice) {
            return response()->json([
                'message' => 'Ankara haipo.',
            ], 404);
        }

        $validated = $request->validate([
            'title'           => 'sometimes|required|string|max:255',
            'invoice_number'  => 'nullable|string|max:255',
            'invoice_date'    => 'nullable|date',
            'due_date'        => 'nullable|date',
            'sub_total'       => 'nullable|numeric|min:0',
            'credit'          => 'nullable|numeric|min:0',
            'total'           => 'nullable|numeric|min:0',
            'status'          => 'nullable|string|in:paid,unpaid,overdue,Lipiwa,Halijalipiwa,Imechelewa',
            'transactions'    => 'nullable|array',
            'transactions.*.date'           => 'nullable|date',
            'transactions.*.gateway'        => 'nullable|string|max:255',
            'transactions.*.transaction_id' => 'nullable|string|max:255',
            'transactions.*.amount'         => 'nullable|numeric|min:0',
        ]);

        // Normalize Swahili status to English
        if (isset($validated['status'])) {
            $validated['status'] = $this->normalizeStatus($validated['status']);
        }

        $invoice->update($validated);

        return response()->json([
            'message' => 'Ankara imesasishwa.',
            'data' => $this->formatInvoice($invoice->fresh(['uploader:id,full_name'])),
        ]);
    }

    /**
     * View an invoice file inline in the browser.
     */
    public function view($id)
    {
        $invoice = Invoice::find($id);

        if (! $invoice) {
            return response()->json([
                'message' => 'Ankara haipo.',
            ], 404);
        }

        if (! $invoice->file_path || ! Storage::disk('public')->exists($invoice->file_path)) {
            return response()->json([
                'message' => 'Faili la ankara halipo.',
            ], 404);
        }

        $path = Storage::disk('public')->path($invoice->file_path);

        return response()->file($path, [
            'Content-Type' => $invoice->file_type ?? 'application/pdf',
            'Content-Disposition' => 'inline; filename="' . $invoice->title . '.pdf"',
        ]);
    }

    /**
     * Download an invoice file.
     */
    public function download($id)
    {
        $invoice = Invoice::find($id);

        if (! $invoice) {
            return response()->json([
                'message' => 'Ankara haipo.',
            ], 404);
        }

        if (! $invoice->file_path || ! Storage::disk('public')->exists($invoice->file_path)) {
            return response()->json([
                'message' => 'Faili la ankara halipo.',
            ], 404);
        }

        $extension = pathinfo($invoice->file_path, PATHINFO_EXTENSION);
        $fileName = $invoice->title . ($extension ? '.' . $extension : '.pdf');

        return Storage::disk('public')->download($invoice->file_path, $fileName);
    }

    /**
     * Delete an invoice.
     */
    public function destroy($id)
    {
        $invoice = Invoice::find($id);

        if (! $invoice) {
            return response()->json([
                'message' => 'Ankara haipo.',
            ], 404);
        }

        if ($invoice->file_path && Storage::disk('public')->exists($invoice->file_path)) {
            Storage::disk('public')->delete($invoice->file_path);
        }

        $invoice->delete();

        return response()->json([
            'message' => 'Ankara imefutwa.',
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
     * Format an invoice for API response.
     */
    private function formatInvoice(Invoice $item): array
    {
        return [
            'id'              => $item->id,
            'title'           => $item->title,
            'invoice_number'  => $item->invoice_number ?? '#' . $item->id,
            'invoice_date'    => optional($item->invoice_date)->format('Y-m-d') ?? optional($item->created_at)->format('Y-m-d'),
            'due_date'        => optional($item->due_date)->format('Y-m-d'),
            'sub_total'       => $item->sub_total ? (float) $item->sub_total : null,
            'credit'          => $item->credit ? (float) $item->credit : 0,
            'total'           => $item->total ? (float) $item->total : null,
            'status'          => $item->status ?? 'unpaid',
            'transactions'    => $item->transactions,
            'file_path'       => $item->file_path,
            'file_url'        => $item->file_url,
            'download_url'    => $item->file_path ? url("/api/invoices/{$item->id}/download") : null,
            'view_url'        => $item->file_path ? url("/api/invoices/{$item->id}/view") : null,
            'file_type'       => $item->file_type,
            'uploaded_by_id'  => $item->uploaded_by_id,
            'uploaded_by_role'=> $item->uploaded_by_role,
            'created_at'      => $item->created_at,
            'updated_at'      => $item->updated_at,
        ];
    }
}
