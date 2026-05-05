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
            $search = $request->search;
            $query->where(function ($q) use ($search) {
                $q->where('title', 'like', '%' . $search . '%')
                  ->orWhere('service_name', 'like', '%' . $search . '%')
                  ->orWhere('preacher', 'like', '%' . $search . '%');
            });
        }

        if ($request->has('category') && $request->category !== 'All') {
            $query->where('category', $request->category);
        }

        return response()->json([
            'status' => 'success',
            'service_events' => $query->orderByDesc('date')->get(),
        ]);
    }

    /**
     * Store a newly created service event.
     */
    public function store(Request $request)
    {
        $validated = $request->validate([
            'title' => 'nullable|string|max:255',
            'date' => 'required|date',
            'time' => 'nullable',
            'location' => 'nullable|string|max:255',
            'category' => 'nullable|string|max:100',
            'description' => 'nullable|string',
            'service_name' => 'required|string|max:255',
            'preacher' => 'nullable|string|max:255',
            'preacher_description' => 'nullable|string|max:500',
            'message' => 'nullable|string',
            'attendance_children' => 'nullable|integer|min:0',
            'attendance_women' => 'nullable|integer|min:0',
            'attendance_men' => 'nullable|integer|min:0',
            'total_offerings' => 'nullable|numeric|min:0',
            'leaders_on_duty' => 'nullable|string|max:255',
        ]);

        // Auto-calculate total attendance
        $validated['total_attendance'] = ($validated['attendance_children'] ?? 0)
            + ($validated['attendance_women'] ?? 0)
            + ($validated['attendance_men'] ?? 0);

        $serviceEvent = ServiceEvent::create($validated);

        return response()->json([
            'status' => 'success',
            'message' => 'Taarifa ya ibada imeongezwa.',
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
            'title' => 'nullable|string|max:255',
            'date' => 'sometimes|required|date',
            'time' => 'nullable',
            'location' => 'nullable|string|max:255',
            'category' => 'nullable|string|max:100',
            'description' => 'nullable|string',
            'service_name' => 'sometimes|required|string|max:255',
            'preacher' => 'nullable|string|max:255',
            'preacher_description' => 'nullable|string|max:500',
            'message' => 'nullable|string',
            'attendance_children' => 'nullable|integer|min:0',
            'attendance_women' => 'nullable|integer|min:0',
            'attendance_men' => 'nullable|integer|min:0',
            'total_offerings' => 'nullable|numeric|min:0',
            'leaders_on_duty' => 'nullable|string|max:255',
        ]);

        // Recalculate total attendance if any attendance field changed
        $validated['total_attendance'] = ($validated['attendance_children'] ?? $serviceEvent->attendance_children)
            + ($validated['attendance_women'] ?? $serviceEvent->attendance_women)
            + ($validated['attendance_men'] ?? $serviceEvent->attendance_men);

        $serviceEvent->update($validated);

        return response()->json([
            'status' => 'success',
            'message' => 'Taarifa ya ibada imesasishwa.',
            'service_event' => $serviceEvent->fresh(),
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
