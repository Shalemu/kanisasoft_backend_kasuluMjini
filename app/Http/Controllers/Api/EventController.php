<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Event;
use Illuminate\Http\Request;
use Carbon\Carbon;

class EventController extends Controller
{
    /**
     * Display a listing of events, with optional search and category filtering.
     */
    public function index(Request $request)
    {
        $query = Event::query();

        // Show only today and future events
        $query->whereDate('date', '>=', Carbon::today());

        if ($request->has('search')) {
            $query->where('title', 'like', '%' . $request->search . '%');
        }

        if ($request->has('category') && $request->category !== 'All') {
            $query->where('category', $request->category);
        }

        return response()->json([
            'status' => 'success',
            'events' => $query->orderBy('date', 'asc')->get(),
        ]);
    }

    public function pastEvents(Request $request)
{
    $query = Event::query();

    // Show only past events
    $query->whereDate('date', '<', Carbon::today());

    if ($request->has('search')) {
        $query->where('title', 'like', '%' . $request->search . '%');
    }

    if ($request->has('category') && $request->category !== 'All') {
        $query->where('category', $request->category);
    }

    return response()->json([
        'status' => 'success',
        'events' => $query->orderBy('date', 'desc')->get(),
    ]);
}
    /**
     * Store a newly created event in storage.
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

        $event = Event::create($validated);

        return response()->json([
            'status' => 'success',
            'message' => 'Event created successfully.',
            'event' => $event,
        ]);
    }

    /**
     * Display the specified event.
     */
    public function show(Event $event)
    {
        return response()->json([
            'status' => 'success',
            'event' => $event,
        ]);
    }

    /**
     * Update the specified event in storage.
     */
    public function update(Request $request, Event $event)
    {
        $validated = $request->validate([
            'title' => 'sometimes|required|string|max:255',
            'date' => 'sometimes|required|date',
            'time' => 'nullable',
            'location' => 'nullable|string|max:255',
            'category' => 'nullable|string|max:100',
            'description' => 'nullable|string',
        ]);

        $event->update($validated);

        return response()->json([
            'status' => 'success',
            'message' => 'Event updated successfully.',
            'event' => $event,
        ]);
    }

    /**
     * Remove the specified event from storage.
     */
    public function destroy(Event $event)
    {
        $event->delete();

        return response()->json([
            'status' => 'success',
            'message' => 'Event deleted successfully.',
        ]);
    }
}
