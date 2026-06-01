<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\ContributionType;

class ContributionTypeController extends Controller
{
    public function index()
    {
        return response()->json([
            'status' => 'success',
            'types' => ContributionType::all(),
        ]);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'name' => 'required|string|unique:contribution_types,name|max:255'
        ]);

        $type = ContributionType::create($validated);

        return response()->json([
            'status' => 'success',
            'type' => $type,
        ]);
    }

    public function update(Request $request, $id)
    {
        $validated = $request->validate(['name' => 'required|string|unique:contribution_types,name,' . $id]);
    
        $type = ContributionType::findOrFail($id);
        $type->update($validated);
    
        return response()->json(['status' => 'success', 'message' => 'Type updated successfully.']);
    }
    
    public function destroy($id)
    {
        $type = ContributionType::findOrFail($id);
        $type->delete();
    
        return response()->json(['status' => 'success', 'message' => 'Type deleted successfully.']);
    }
    
}
