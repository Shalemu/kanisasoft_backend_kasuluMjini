<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Asset;
use Illuminate\Http\Request;

class AssetController extends Controller
{
    // Get all assets
    public function index()
    {
        $assets = Asset::orderBy('created_at', 'desc')->get();
        return response()->json(['assets' => $assets]);
    }

    // Store new asset
    public function store(Request $request)
    {
        $validated = $request->validate([
            'name' => 'required|string',
            'category' => 'required|string',
            'quantity' => 'required|integer|min:1',
            'location' => 'nullable|string',
            'acquired_date' => 'nullable|date',
            'value' => 'nullable|numeric',
            'description' => 'nullable|string',
        ]);

        $asset = Asset::create($validated);

        return response()->json([
            'status' => 'success',
            'message' => 'Asset added successfully',
            'asset' => $asset
        ]);
    }

    // Update asset
    public function update(Request $request, $id)
    {
        $asset = Asset::findOrFail($id);

        $validated = $request->validate([
            'name' => 'required|string',
            'category' => 'required|string',
            'quantity' => 'required|integer|min:1',
            'location' => 'nullable|string',
            'acquired_date' => 'nullable|date',
            'value' => 'nullable|numeric',
            'description' => 'nullable|string',
        ]);

        $asset->update($validated);

        return response()->json([
            'status' => 'success',
            'message' => 'Asset updated successfully',
            'asset' => $asset
        ]);
    }

    // Delete asset
    public function destroy($id)
    {
        $asset = Asset::findOrFail($id);
        $asset->delete();

        return response()->json([
            'status' => 'deleted',
            'message' => 'Asset deleted successfully'
        ]);
    }
}
