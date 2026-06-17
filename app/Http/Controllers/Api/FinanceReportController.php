<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Contribution;
use App\Models\Sadaka;
use App\Models\Zaka;
use Illuminate\Http\Request;

class FinanceReportController extends Controller
{
    /**
     * Get aggregated finance report for Sadaka, Zaka, and Michango.
     *
     * Query params:
     *   ?year=2026        — filter by year (default: current year)
     *   ?start_date=...   — filter from date
     *   ?end_date=...     — filter to date
     */
    public function index(Request $request)
    {
        $request->validate([
            'year'       => 'nullable|integer|min:2000|max:2100',
            'start_date' => 'nullable|date',
            'end_date'   => 'nullable|date|after_or_equal:start_date',
        ]);

        $year = $request->input('year', now()->year);
        $startDate = $request->input('start_date', "{$year}-01-01");
        $endDate = $request->input('end_date', "{$year}-12-31");

        // Fetch filtered data
        $sadaka = Sadaka::whereDate('date', '>=', $startDate)
            ->whereDate('date', '<=', $endDate)
            ->orderBy('date')
            ->get();

        $zaka = Zaka::whereDate('date', '>=', $startDate)
            ->whereDate('date', '<=', $endDate)
            ->orderBy('date')
            ->get();

        $michango = Contribution::whereDate('date', '>=', $startDate)
            ->whereDate('date', '<=', $endDate)
            ->orderBy('date')
            ->get();

        // Monthly aggregation (index 0 = Jan, 11 = Dec)
        $monthlySadaka = $this->monthlyAgg($sadaka, 'date', 'amount');
        $monthlyZaka = $this->monthlyAgg($zaka, 'date', 'amount');
        $monthlyMichango = $this->monthlyAgg($michango, 'date', 'amount');

        // Totals
        $totalSadaka = $sadaka->sum('amount');
        $totalZaka = $zaka->sum('amount');
        $totalMichango = $michango->sum('amount');

        // Combined records (all three types in one list)
        $records = collect();

        foreach ($sadaka as $s) {
            $records->push([
                'id'       => $s->id,
                'category' => 'Sadaka',
                'date'     => optional($s->date)->format('Y-m-d'),
                'amount'   => (float) $s->amount,
                'detail'   => $s->service_name,
            ]);
        }

        foreach ($zaka as $z) {
            $records->push([
                'id'       => $z->id,
                'category' => 'Zaka',
                'date'     => optional($z->date)->format('Y-m-d'),
                'amount'   => (float) $z->amount,
                'detail'   => $z->member_name,
            ]);
        }

        foreach ($michango as $m) {
            $records->push([
                'id'       => $m->id,
                'category' => 'Michango',
                'date'     => optional($m->date)->format('Y-m-d'),
                'amount'   => (float) $m->amount,
                'detail'   => $m->donor_name ?? $m->member_name ?? $m->giver_name,
            ]);
        }

        // Sort combined records by date desc
        $records = $records->sortByDesc('date')->values();

        return response()->json([
            'status' => 'success',
            'data'   => [
                'monthly' => [
                    'sadaka'   => $monthlySadaka,
                    'zaka'     => $monthlyZaka,
                    'michango' => $monthlyMichango,
                ],
                'totals' => [
                    'sadaka'      => (float) $totalSadaka,
                    'zaka'        => (float) $totalZaka,
                    'michango'    => (float) $totalMichango,
                    'grand_total' => (float) ($totalSadaka + $totalZaka + $totalMichango),
                ],
                'sadaka'   => $sadaka->map(fn ($s) => [
                    'id'     => $s->id,
                    'date'   => optional($s->date)->format('Y-m-d'),
                    'amount' => (float) $s->amount,
                ]),
                'zaka'     => $zaka->map(fn ($z) => [
                    'id'     => $z->id,
                    'date'   => optional($z->date)->format('Y-m-d'),
                    'amount' => (float) $z->amount,
                ]),
                'michango' => $michango->map(fn ($m) => [
                    'id'     => $m->id,
                    'date'   => optional($m->date)->format('Y-m-d'),
                    'amount' => (float) $m->amount,
                ]),
                'records' => $records,
            ],
        ]);
    }

    /**
     * Aggregate amounts by month (0-indexed, 12 elements).
     */
    private function monthlyAgg($items, string $dateField, string $amountField): array
    {
        $months = array_fill(0, 12, 0);

        foreach ($items as $item) {
            $monthIndex = optional($item->$dateField)->month;
            if ($monthIndex) {
                $months[$monthIndex - 1] += (float) $item->$amountField;
            }
        }

        return array_map(fn ($v) => (float) $v, $months);
    }
}