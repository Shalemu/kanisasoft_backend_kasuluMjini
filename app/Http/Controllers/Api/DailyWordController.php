<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\DailyWord;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;

class DailyWordController extends Controller
{
    public function index(Request $request)
    {
        $query = DailyWord::with('author:id,full_name,role')
            ->orderBy('scheduled_date', $request->input('order', 'asc') === 'desc' ? 'desc' : 'asc');

        if ($request->filled('from')) {
            $query->whereDate('scheduled_date', '>=', $request->input('from'));
        }

        if ($request->filled('to')) {
            $query->whereDate('scheduled_date', '<=', $request->input('to'));
        }

        if ($request->filled('search')) {
            $search = $request->input('search');
            $query->where(function ($searchQuery) use ($search) {
                $searchQuery
                    ->where('scripture_reference', 'like', '%' . $search . '%')
                    ->orWhere('verse_text', 'like', '%' . $search . '%')
                    ->orWhere('explanation', 'like', '%' . $search . '%');
            });
        }

        return response()->json([
            'status' => 'success',
            'daily_words' => $query->get()->map(fn (DailyWord $dailyWord) => $this->formatDailyWord($dailyWord)),
        ]);
    }

    public function today(Request $request)
    {
        $date = $request->input('date', Carbon::today()->toDateString());

        $dailyWord = DailyWord::with('author:id,full_name,role')
            ->whereDate('scheduled_date', $date)
            ->first();

        return response()->json([
            'status' => 'success',
            'date' => $date,
            'daily_word' => $dailyWord ? $this->formatDailyWord($dailyWord) : null,
        ]);
    }

    public function stats()
    {
        $today = Carbon::today();
        $monthStart = $today->copy()->startOfMonth();
        $monthEnd = $today->copy()->endOfMonth();

        return response()->json([
            'status' => 'success',
            'stats' => [
                'total' => DailyWord::count(),
                'today_available' => DailyWord::whereDate('scheduled_date', $today)->exists(),
                'this_month' => DailyWord::whereBetween('scheduled_date', [$monthStart, $monthEnd])->count(),
                'upcoming' => DailyWord::whereDate('scheduled_date', '>', $today)->count(),
                'past' => DailyWord::whereDate('scheduled_date', '<', $today)->count(),
                'next_scheduled_date' => DailyWord::whereDate('scheduled_date', '>', $today)
                    ->orderBy('scheduled_date')
                    ->value('scheduled_date'),
            ],
        ]);
    }

    public function store(Request $request)
    {
        $this->authorizeDailyWordManagement($request);

        $validated = $this->validatedPayload($request);
        $validated['created_by'] = $request->user()->id;

        $dailyWord = DailyWord::create($validated);

        return response()->json([
            'status' => 'success',
            'message' => 'Neno la siku limehifadhiwa.',
            'daily_word' => $this->formatDailyWord($dailyWord->load('author:id,full_name,role')),
        ], 201);
    }

    public function bulkStore(Request $request)
    {
        $this->authorizeDailyWordManagement($request);

        $validated = $request->validate([
            'entries' => 'required|array|min:1|max:31',
            'entries.*.scheduled_date' => 'required|date|distinct',
            'entries.*.scripture_reference' => 'required|string|max:255',
            'entries.*.verse_text' => 'required|string',
            'entries.*.explanation' => 'required|string',
            'entries.*.author_name' => 'nullable|string|max:255',
        ]);

        $created = collect();
        $updated = collect();

        foreach ($validated['entries'] as $entry) {
            $dailyWord = DailyWord::updateOrCreate(
                ['scheduled_date' => $entry['scheduled_date']],
                array_merge($entry, ['created_by' => $request->user()->id])
            );

            $dailyWord->wasRecentlyCreated ? $created->push($dailyWord) : $updated->push($dailyWord);
        }

        return response()->json([
            'status' => 'success',
            'message' => 'Ratiba ya Neno la Siku imehifadhiwa.',
            'created_count' => $created->count(),
            'updated_count' => $updated->count(),
            'daily_words' => DailyWord::with('author:id,full_name,role')
                ->whereIn('scheduled_date', collect($validated['entries'])->pluck('scheduled_date'))
                ->orderBy('scheduled_date')
                ->get()
                ->map(fn (DailyWord $dailyWord) => $this->formatDailyWord($dailyWord)),
        ], 201);
    }

    public function show(DailyWord $dailyWord)
    {
        return response()->json([
            'status' => 'success',
            'daily_word' => $this->formatDailyWord($dailyWord->load('author:id,full_name,role')),
        ]);
    }

    public function update(Request $request, DailyWord $dailyWord)
    {
        $this->authorizeDailyWordManagement($request);

        $dailyWord->update($this->validatedPayload($request, $dailyWord));

        return response()->json([
            'status' => 'success',
            'message' => 'Neno la siku limesasishwa.',
            'daily_word' => $this->formatDailyWord($dailyWord->fresh('author:id,full_name,role')),
        ]);
    }

    public function destroy(Request $request, DailyWord $dailyWord)
    {
        $this->authorizeDailyWordManagement($request);

        $dailyWord->delete();

        return response()->json([
            'status' => 'success',
            'message' => 'Neno la siku limefutwa.',
        ]);
    }

    private function validatedPayload(Request $request, ?DailyWord $dailyWord = null): array
    {
        return $request->validate([
            'scheduled_date' => [
                $dailyWord ? 'sometimes' : 'required',
                'date',
                Rule::unique('daily_words', 'scheduled_date')->ignore($dailyWord?->id),
            ],
            'scripture_reference' => [$dailyWord ? 'sometimes' : 'required', 'string', 'max:255'],
            'verse_text' => [$dailyWord ? 'sometimes' : 'required', 'string'],
            'explanation' => [$dailyWord ? 'sometimes' : 'required', 'string'],
            'author_name' => 'nullable|string|max:255',
        ]);
    }

    private function authorizeDailyWordManagement(Request $request): void
    {
        $role = $request->user()?->role;

        if (! in_array($role, ['admin', 'mchungaji'], true)) {
            abort(response()->json([
                'status' => 'error',
                'message' => 'Ni admin au mchungaji pekee anaweza kusimamia Neno la Siku.',
            ], 403));
        }
    }

    private function formatDailyWord(DailyWord $dailyWord): array
    {
        return [
            'id' => $dailyWord->id,
            'scheduled_date' => $dailyWord->scheduled_date?->format('Y-m-d'),
            'scripture_reference' => $dailyWord->scripture_reference,
            'verse_text' => $dailyWord->verse_text,
            'explanation' => $dailyWord->explanation,
            'author_name' => $dailyWord->author_name ?: $dailyWord->author?->full_name,
            'created_by' => $dailyWord->created_by,
            'author' => $dailyWord->author,
            'created_at' => $dailyWord->created_at?->toISOString(),
            'updated_at' => $dailyWord->updated_at?->toISOString(),
        ];
    }
}
