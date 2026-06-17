<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Rasilimali;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class RasilimaliController extends Controller
{
    /**
     * Get all resources with optional search.
     */
    public function index(Request $request)
    {
        $query = Rasilimali::with('uploader:id,full_name');

        if ($request->filled('search')) {
            $search = $request->input('search');
            $query->where(function ($q) use ($search) {
                $q->where('title', 'like', "%{$search}%")
                  ->orWhere('description', 'like', "%{$search}%");
            });
        }

        $rasilimali = $query->orderBy('created_at', 'desc')
            ->get()
            ->map(function ($item) {
                return $this->formatResource($item);
            });

        return response()->json($rasilimali);
    }

    /**
     * View a single resource.
     */
    public function show($id)
    {
        $resource = Rasilimali::with('uploader:id,full_name')->find($id);

        if (! $resource) {
            return response()->json([
                'message' => 'Rasilimali haipo.',
            ], 404);
        }

        return response()->json($this->formatResource($resource));
    }

    /**
     * Update a resource.
     */
    public function update(Request $request, $id)
    {
        $resource = Rasilimali::find($id);

        if (! $resource) {
            return response()->json([
                'message' => 'Rasilimali haipo.',
            ], 404);
        }

        $data = $request->validate([
            'title'       => 'sometimes|required|string|max:255',
            'description' => 'nullable|string',
            'link'        => 'nullable|url',
            'file'        => 'nullable|file|mimes:pdf,doc,docx,xls,xlsx|max:10240',
        ]);

        if ($request->hasFile('file')) {
            // Delete old file
            if ($resource->file_path && Storage::disk('public')->exists($resource->file_path)) {
                Storage::disk('public')->delete($resource->file_path);
            }
            $file = $request->file('file');
            $data['file_path'] = $file->store('rasilimali', 'public');
            $data['file_type'] = $file->getMimeType();
        }

        unset($data['file']);

        $resource->update($data);
        $resource->load('uploader:id,full_name');

        return response()->json([
            'message' => 'Rasilimali imesasishwa.',
            'data' => $this->formatResource($resource),
        ]);
    }

    /**
     * Store a new resource.
     */
    public function store(Request $request)
    {
        $data = $request->validate([
            'title'       => 'required|string|max:255',
            'description' => 'nullable|string',
            'link'        => 'nullable|url',
            'file'        => 'nullable|file|mimes:pdf,doc,docx,xls,xlsx|max:10240',
        ]);

        if ($request->hasFile('file')) {
            $file = $request->file('file');
            $path = $file->store('rasilimali', 'public');
            $data['file_path'] = $path;
            $data['file_type'] = $file->getMimeType();
        }

        unset($data['file']);

        $data['uploaded_by_id']   = auth()->id();
        $data['uploaded_by_role'] = auth()->user()->role ?? 'Mtumiaji';

        $resource = Rasilimali::create($data);
        $resource->load('uploader:id,full_name');

        return response()->json([
            'message' => 'Rasilimali imehifadhiwa.',
            'data' => $this->formatResource($resource),
        ], 201);
    }

    /**
     * View a resource file inline in the browser.
     */
    public function view($id)
    {
        $resource = Rasilimali::find($id);

        if (! $resource) {
            return response()->json([
                'message' => 'Rasilimali haipo.',
            ], 404);
        }

        if (! $resource->file_path || ! Storage::disk('public')->exists($resource->file_path)) {
            return response()->json([
                'message' => 'Faili la rasilimali halipo.',
            ], 404);
        }

        $path = Storage::disk('public')->path($resource->file_path);

        return response()->file($path, [
            'Content-Type' => $resource->file_type ?? 'application/pdf',
            'Content-Disposition' => 'inline; filename="' . $resource->title . '"',
        ]);
    }

    /**
     * Download a resource file.
     */
    public function download($id)
    {
        $resource = Rasilimali::find($id);

        if (! $resource) {
            return response()->json([
                'message' => 'Rasilimali haipo.',
            ], 404);
        }

        if (! $resource->file_path || ! Storage::disk('public')->exists($resource->file_path)) {
            return response()->json([
                'message' => 'Faili la rasilimali halipo.',
            ], 404);
        }

        $extension = pathinfo($resource->file_path, PATHINFO_EXTENSION);
        $fileName = $resource->title . ($extension ? '.' . $extension : '');

        return Storage::disk('public')->download($resource->file_path, $fileName);
    }

    /**
     * Delete a resource.
     */
    public function destroy($id)
    {
        $resource = Rasilimali::find($id);

        if (! $resource) {
            return response()->json([
                'message' => 'Rasilimali haipo.',
            ], 404);
        }

        // Delete the file from storage
        if ($resource->file_path && Storage::disk('public')->exists($resource->file_path)) {
            Storage::disk('public')->delete($resource->file_path);
        }

        $resource->delete();

        return response()->json([
            'message' => 'Rasilimali imefutwa.',
        ]);
    }

    /**
     * Format a resource for API response.
     */
    private function formatResource(Rasilimali $item): array
    {
        return [
            'id' => $item->id,
            'title' => $item->title,
            'description' => $item->description,
            'link' => $item->link,
            'file_path' => $item->file_path,
            'file_url' => $item->file_url,
            'download_url' => $item->file_path ? url("/api/resources/{$item->id}/download") : null,
            'view_url' => $item->file_path ? url("/api/resources/{$item->id}/view") : null,
            'file_type' => $item->file_type,
            'uploaded_by_id' => $item->uploaded_by_id,
            'uploaded_by_role' => $item->uploaded_by_role,
            'created_at' => $item->created_at,
            'updated_at' => $item->updated_at,
        ];
    }
}
