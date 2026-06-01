<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Gallery;
use Illuminate\Support\Facades\Storage;

class GalleryController extends Controller
{
    /**
     * Get all gallery images with full URLs.
     */
    public function index()
    {
        $images = Gallery::latest()->get()->map(function ($image) {
            return [
                'id' => $image->id,
                'title' => $image->title,
                'url' => asset('storage/' . $image->image),
            ];
        });

        return response()->json([
            'status' => 'success',
            'images' => $images,
        ]);
    }

    /**
     * Store a new uploaded image with title and return full URL.
     */
    public function store(Request $request)
    {
        $request->validate([
            'image' => 'required|image|max:2048',
            'title' => 'nullable|string|max:255',
        ]);

        $path = $request->file('image')->store('gallery', 'public');

        $gallery = Gallery::create([
            'image' => $path,
            'title' => $request->title,
        ]);

        return response()->json([
            'status' => 'success',
            'message' => 'Image uploaded successfully',
            'image' => [
                'id' => $gallery->id,
                'title' => $gallery->title,
                'url' => asset('storage/' . $gallery->image),
            ],
        ]);
    }

    /**
     * Delete a gallery image and remove file from storage.
     */
    public function destroy($id)
    {
        $image = Gallery::find($id);

        if (!$image) {
            return response()->json([
                'status' => 'error',
                'message' => 'Image not found.',
            ], 404);
        }

        // Delete the file from storage
        if (Storage::disk('public')->exists($image->image)) {
            Storage::disk('public')->delete($image->image);
        }

        $image->delete();

        return response()->json([
            'status' => 'success',
            'message' => 'Image deleted successfully.',
        ]);
    }
}
