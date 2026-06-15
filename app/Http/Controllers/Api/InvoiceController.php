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
            ->map(function ($item) {
                return [
                    'id' => $item->id,
                    'title' => $item->title,
                    'file_path' => $item->file_path,
                    'file_url' => $item->file_url,
                    'download_url' => url("/api/invoices/{$item->id}/download"),
                    'file_type' => $item->file_type,
                    'uploaded_by_id' => $item->uploaded_by_id,
                    'uploaded_by_role' => $item->uploaded_by_role,
                    'created_at' => $item->created_at,
                    'updated_at' => $item->updated_at,
                ];
            });

        return response()->json($invoices);
    }

    /**
     * Store a new invoice (PDF upload).
     */
    public function store(Request $request)
    {
        $data = $request->validate([
            'title' => 'required|string|max:255',
            'file' => 'required|file|mimes:pdf|max:20480',
        ]);

        $file = $request->file('file');
        $path = $file->store('invoices', 'public');

        $invoice = Invoice::create([
            'title' => $data['title'],
            'file_path' => $path,
            'file_type' => $file->getMimeType(),
            'uploaded_by_id' => auth()->id(),
            'uploaded_by_role' => auth()->user()->role ?? 'Admin',
        ]);

        $invoice->load('uploader:id,full_name');

        return response()->json([
            'message' => 'Ankara imehifadhiwa.',
            'data' => [
                'id' => $invoice->id,
                'title' => $invoice->title,
                'file_path' => $invoice->file_path,
                'file_url' => $invoice->file_url,
                'download_url' => url("/api/invoices/{$invoice->id}/download"),
                'file_type' => $invoice->file_type,
                'uploaded_by_id' => $invoice->uploaded_by_id,
                'uploaded_by_role' => $invoice->uploaded_by_role,
                'created_at' => $invoice->created_at,
                'updated_at' => $invoice->updated_at,
            ],
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
            'title' => 'sometimes|required|string|max:255',
        ]);

        $invoice->update($validated);

        return response()->json([
            'message' => 'Ankara imesasishwa.',
            'data' => [
                'id' => $invoice->id,
                'title' => $invoice->title,
                'file_path' => $invoice->file_path,
                'file_url' => $invoice->file_url,
                'download_url' => url("/api/invoices/{$invoice->id}/download"),
                'file_type' => $invoice->file_type,
                'uploaded_by_id' => $invoice->uploaded_by_id,
                'uploaded_by_role' => $invoice->uploaded_by_role,
                'created_at' => $invoice->created_at,
                'updated_at' => $invoice->updated_at,
            ],
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
}
