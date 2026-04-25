<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\ServiceEvent;
use Illuminate\Http\Request;

class ServiceEventController extends Controller
{
    /**
     * Display a listing of service events, with optional search and category filtering.
     */
    public function index(Request $request)
    {
        $query = ServiceEvent::query();

        if ($request->has('search')) {
            $query->where('title', 'like', '%' . $request->search . '%');
        }

        if ($request->has('category') && $request->category !== 'All') {
            $query->where('category', $request->category);
        }

        return response()->json([
            'status' => 'success',
            'service_events' => $query->orderBy('date')->get(),
        ]);
    }

    /**
     * Store a newly created service event.
     */
    public function store(Request $request)
    {
        $validated = $request->validate([
            'title' => 'required|string|max:255',
            'date' => 'required|date',
            'time' => 'nullable',
            'location' => 'nullable|string|max:255',
            'category' => 'nullable|string|max:100',
            'description' => 'nullable|string',
        ]);

        $serviceEvent = ServiceEvent::create($validated);

        return response()->json([
            'status' => 'success',
            'message' => 'Service event created successfully.',
            'service_event' => $serviceEvent,
        ]);
    }

    /**
     * Display the specified service event.
     */
    public function show(ServiceEvent $serviceEvent)
    {
        return response()->json([
            'status' => 'success',
            'service_event' => $serviceEvent,
        ]);
    }

    /**
     * Update the specified service event.
     */
    public function update(Request $request, ServiceEvent $serviceEvent)
    {
        $validated = $request->validate([
            'title' => 'sometimes|required|string|max:255',
            'date' => 'sometimes|required|date',
            'time' => 'nullable',
            'location' => 'nullable|string|max:255',
            'category' => 'nullable|string|max:100',
            'description' => 'nullable|string',
        ]);

        $serviceEvent->update($validated);

        return response()->json([
            'status' => 'success',
            'message' => 'Service event updated successfully.',
            'service_event' => $serviceEvent,
        ]);
    }

    /**
     * Remove the specified service event.
     */
    public function destroy(ServiceEvent $serviceEvent)
    {
        $serviceEvent->delete();

        return response()->json([
            'status' => 'success',
            'message' => 'Service event deleted successfully.',
        ]);
    }
}
