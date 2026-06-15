<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Rasilimali;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class RasilimaliController extends Controller
{
    /**
     * Get all resources.
     */
    public function index()
    {
        $rasilimali = Rasilimali::with('uploader:id,full_name')
            ->orderBy('created_at', 'desc')
            ->get()
            ->map(function ($item) {
                return [
                    'id' => $item->id,
                    'title' => $item->title,
                    'description' => $item->description,
                    'link' => $item->link,
                    'file_path' => $item->file_path,
                    'file_url' => $item->file_url,
                    'download_url' => $item->file_path ? url("/api/rasilimali/{$item->id}/download") : null,
                    'file_type' => $item->file_type,
                    'uploaded_by_id' => $item->uploaded_by_id,
                    'uploaded_by_role' => $item->uploaded_by_role,
                    'created_at' => $item->created_at,
                    'updated_at' => $item->updated_at,
                ];
            });

        return response()->json($rasilimali);
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
            'data' => [
                'id' => $resource->id,
                'title' => $resource->title,
                'description' => $resource->description,
                'link' => $resource->link,
                'file_path' => $resource->file_path,
                'file_url' => $resource->file_url,
                'download_url' => $resource->file_path ? url("/api/rasilimali/{$resource->id}/download") : null,
                'file_type' => $resource->file_type,
                'uploaded_by_id' => $resource->uploaded_by_id,
                'uploaded_by_role' => $resource->uploaded_by_role,
                'created_at' => $resource->created_at,
                'updated_at' => $resource->updated_at,
            ],
        ], 201);
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
}
