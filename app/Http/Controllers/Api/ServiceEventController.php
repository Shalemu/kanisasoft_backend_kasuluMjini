<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\ServiceEvent;
use Illuminate\Http\Request;

class ServiceEventController extends Controller
{
    private function normalizePayload(Request $request): void
    {
        $this->mergeFirstFilled($request, 'service_name', [
            'service_type',
            'serviceType',
            'worship_type',
            'worshipType',
            'type',
            'service',
            'category',
        ]);

        $this->mergeFirstFilled($request, 'title', [
            'service_name',
            'service_type',
            'serviceType',
            'worship_type',
            'worshipType',
            'type',
            'service',
            'category',
        ]);

        $this->mergeFirstFilled($request, 'date', ['service_date', 'serviceDate', 'visit_date']);
        $this->mergeFirstFilled($request, 'preacher', ['mhubiri', 'minister']);
        $this->mergeFirstFilled($request, 'preacher_description', ['sermon', 'sermon_title', 'sermonTitle', 'mahubiri']);
        $this->mergeFirstFilled($request, 'message', ['ujumbe']);
        $this->mergeFirstFilled($request, 'leaders_on_duty', ['service_leader', 'serviceLeader', 'worship_leader', 'worshipLeader', 'leader']);
        $this->mergeFirstFilled($request, 'attendance_children', ['children', 'children_attendance', 'childrenAttendance']);
        $this->mergeFirstFilled($request, 'attendance_women', ['women', 'women_attendance', 'womenAttendance']);
        $this->mergeFirstFilled($request, 'attendance_men', ['men', 'men_attendance', 'menAttendance']);
        $this->mergeFirstFilled($request, 'total_offerings', ['offerings', 'total_sadaka', 'sadaka']);
    }

    private function mergeFirstFilled(Request $request, string $target, array $aliases): void
    {
        if ($request->filled($target)) {
            return;
        }

        foreach ($aliases as $alias) {
            if ($request->filled($alias)) {
                $request->merge([$target => $request->input($alias)]);

                return;
            }
        }
    }

    /**
     * Get all service events with optional search, category, and date filters.
     */
    public function index(Request $request)
    {
        $request->validate([
            'search' => 'nullable|string|max:255',
            'category' => 'nullable|string|max:100',
            'date' => 'nullable|date',
            'filter_date' => 'nullable|date',
            'from_date' => 'nullable|date',
            'to_date' => 'nullable|date|after_or_equal:from_date',
        ]);

        $query = ServiceEvent::query();

        if ($request->filled('search')) {
            $search = $request->search;

            $query->where(function ($q) use ($search) {
                $q->where('title', 'like', "%{$search}%")
                    ->orWhere('service_name', 'like', "%{$search}%")
                    ->orWhere('preacher', 'like', "%{$search}%");
            });
        }

        if ($request->filled('category') && $request->category !== 'All') {
            $query->where('category', $request->category);
        }

        $selectedDate = $request->input('date', $request->input('filter_date'));
        if (filled($selectedDate)) {
            $query->whereDate('date', $selectedDate);
        }

        if ($request->filled('from_date')) {
            $query->whereDate('date', '>=', $request->from_date);
        }

        if ($request->filled('to_date')) {
            $query->whereDate('date', '<=', $request->to_date);
        }

        return response()->json([
            'status' => 'success',
            'service_events' => $query->orderByDesc('date')->get(),
        ]);
    }

    /**
     * Store new service event
     */
    public function store(Request $request)
    {
        $this->normalizePayload($request);

        $validated = $request->validate([
            'title' => 'required|string|max:255',
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

        // Safe defaults
        $children = $validated['attendance_children'] ?? 0;
        $women = $validated['attendance_women'] ?? 0;
        $men = $validated['attendance_men'] ?? 0;

        $validated['total_attendance'] = $children + $women + $men;

        $serviceEvent = ServiceEvent::create($validated);

        return response()->json([
            'status' => 'success',
            'message' => 'Taarifa ya ibada imeongezwa.',
            'service_event' => $serviceEvent,
        ], 201);
    }

    /**
     * Show single service event
     */
    public function show(ServiceEvent $serviceEvent)
    {
        return response()->json([
            'status' => 'success',
            'service_event' => $serviceEvent,
        ]);
    }

    /**
     * Update service event
     */
    public function update(Request $request, ServiceEvent $serviceEvent)
    {
        $this->normalizePayload($request);

        $validated = $request->validate([
            'title' => 'sometimes|required|string|max:255',
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

        // Recalculate attendance safely
        $children = $validated['attendance_children'] ?? $serviceEvent->attendance_children ?? 0;
        $women = $validated['attendance_women'] ?? $serviceEvent->attendance_women ?? 0;
        $men = $validated['attendance_men'] ?? $serviceEvent->attendance_men ?? 0;

        $validated['total_attendance'] = $children + $women + $men;

        $serviceEvent->update($validated);

        return response()->json([
            'status' => 'success',
            'message' => 'Taarifa ya ibada imesasishwa.',
            'service_event' => $serviceEvent->fresh(),
        ]);
    }

    /**
     * Delete service event
     */
    public function destroy(ServiceEvent $serviceEvent)
    {
        $serviceEvent->delete();

        return response()->json([
            'status' => 'success',
            'message' => 'Service event imefutwa.',
        ]);
    }
}
