<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Event;
use App\Models\Group;
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

        if (! $request->boolean('include_past') && $request->input('scope') !== 'all') {
            $query->whereDate('start_date', '>=', Carbon::today());
        }

        if ($request->has('search')) {
            $query->where(function ($searchQuery) use ($request) {
                $searchQuery
                    ->where('title', 'like', '%' . $request->search . '%')
                    ->orWhere('description', 'like', '%' . $request->search . '%');
            });
        }

        if ($request->has('category') && $request->category !== 'All') {
            $query->where('category', $request->category);
        }

        if ($request->has('type') && $request->type !== 'All') {
            $query->where('type', $this->normalizeType($request->type));
        }

        return response()->json([
            'status' => 'success',
            'label' => 'Matangazo & Matukio',
            'events' => $this->withAudienceGroups($query->orderBy('start_date', 'asc')->get()),
        ]);
    }

    public function pastEvents(Request $request)
    {
        $query = Event::query();

        $query->whereDate('start_date', '<', Carbon::today());

        if ($request->has('search')) {
            $query->where(function ($searchQuery) use ($request) {
                $searchQuery
                    ->where('title', 'like', '%' . $request->search . '%')
                    ->orWhere('description', 'like', '%' . $request->search . '%');
            });
        }

        if ($request->has('category') && $request->category !== 'All') {
            $query->where('category', $request->category);
        }

        if ($request->has('type') && $request->type !== 'All') {
            $query->where('type', $this->normalizeType($request->type));
        }

        return response()->json([
            'status' => 'success',
            'label' => 'Matangazo & Matukio',
            'events' => $this->withAudienceGroups($query->orderBy('start_date', 'desc')->get()),
        ]);
    }
    /**
     * Store a newly created event in storage.
     */
    public function store(Request $request)
    {
        $validated = $this->validatedPayload($request);

        $event = Event::create($validated);

        return response()->json([
            'status' => 'success',
            'message' => 'Announcement/event created successfully.',
            'event' => $this->withAudienceGroups(collect([$event]))->first(),
        ], 201);
    }

    /**
     * Display the specified event.
     */
    public function show(Event $event)
    {
        return response()->json([
            'status' => 'success',
            'event' => $this->withAudienceGroups(collect([$event]))->first(),
        ]);
    }

    /**
     * Update the specified event in storage.
     */
    public function update(Request $request, Event $event)
    {
        $validated = $this->validatedPayload($request, $event);

        $event->update($validated);

        return response()->json([
            'status' => 'success',
            'message' => 'Announcement/event updated successfully.',
            'event' => $this->withAudienceGroups(collect([$event->fresh()]))->first(),
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

    private function validatedPayload(Request $request, ?Event $event = null): array
    {
        $this->mergeAlias($request, 'start_date', ['date']);
        $this->mergeAlias($request, 'start_time', ['time']);
        $this->mergeAlias($request, 'audience_group_ids', ['group_ids', 'audience_groups', 'wahusika']);

        $rules = [
            'title' => $event ? 'sometimes|required|string|max:255' : 'required|string|max:255',
            'type' => 'nullable|string|in:Tangazo,Tukio,Announcement,Event',
            'start_date' => $event ? 'sometimes|required|date' : 'required|date',
            'end_date' => 'nullable|date|after_or_equal:start_date',
            'start_time' => 'nullable|date_format:H:i',
            'location' => 'nullable|string|max:255',
            'category' => 'nullable|string|max:100',
            'description' => 'nullable|string',
            'audience_group_ids' => 'nullable|array',
            'audience_group_ids.*' => 'integer|exists:groups,id',
        ];

        $validated = $request->validate($rules);

        if (array_key_exists('type', $validated)) {
            $validated['type'] = $this->normalizeType($validated['type']);
        } elseif (! $event) {
            $validated['type'] = 'Tukio';
        }

        if (array_key_exists('start_date', $validated)) {
            $validated['date'] = $validated['start_date'];
        }

        if (array_key_exists('start_time', $validated)) {
            $validated['time'] = $validated['start_time'];
        }

        if (! array_key_exists('category', $validated) && ! $event) {
            $validated['category'] = $validated['type'] ?? 'Tukio';
        }

        return $validated;
    }

    private function mergeAlias(Request $request, string $field, array $aliases): void
    {
        if ($request->filled($field)) {
            return;
        }

        foreach ($aliases as $alias) {
            if ($request->filled($alias)) {
                $request->merge([$field => $request->input($alias)]);
                return;
            }
        }
    }

    private function normalizeType(?string $type): string
    {
        return match ($type) {
            'Tangazo', 'Announcement' => 'Tangazo',
            default => 'Tukio',
        };
    }

    private function withAudienceGroups($events)
    {
        $groupIds = $events
            ->flatMap(fn (Event $event) => $event->audience_group_ids ?? [])
            ->unique()
            ->values();

        $groups = $groupIds->isEmpty()
            ? collect()
            : Group::query()
                ->select('id', 'name')
                ->whereIn('id', $groupIds)
                ->get()
                ->keyBy('id');

        return $events->map(function (Event $event) use ($groups) {
            $event->setAttribute('audience_groups', collect($event->audience_group_ids ?? [])
                ->map(fn ($id) => $groups->get((int) $id))
                ->filter()
                ->values());

            return $event;
        });
    }
}
