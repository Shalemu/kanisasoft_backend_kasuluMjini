<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Service;
use App\Models\Attendance;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;

class AttendanceController extends Controller
{
    /**
     * List all attendance summaries, grouped by service/date.
     */
    public function index()
    {
        // Eager load service and uploader
        $attendances = Attendance::with(['service', 'uploader'])->get();

        // Prepare flat summary list with uploader name
        $attendanceSummaries = $attendances->map(function ($att) {
            return [
                'id' => $att->service_id,
                'type' => $att->service->type,
                'date' => $att->service->date,
                'uploaded_by' => $att->uploader?->full_name, // use full_name
                'children' => $att->children,
                'women' => $att->women,
                'men' => $att->men,
                'total' => $att->total,
            ];
        });

        // Group by service_id and sum totals
        $services = $attendanceSummaries
            ->groupBy('id')
            ->map(function ($group) {
                return [
                    'id' => $group->first()['id'],
                    'type' => $group->first()['type'],
                    'date' => $group->first()['date'],
                    'uploaded_by' => $group->first()['uploaded_by'] ?? '-', // fallback
                    'children' => $group->sum('children'),
                    'women' => $group->sum('women'),
                    'men' => $group->sum('men'),
                    'total' => $group->sum('total'),
                ];
            })
            ->sortByDesc('date')
            ->values();

        return response()->json([
            'status' => 'success',
            'attendance' => $services,
        ]);
    }

    /**
     * Store a new attendance record.
     */
    public function store(Request $request)
    {
        $userId = Auth::id();
        if (!$userId) {
            return response()->json([
                'status' => 'error',
                'message' => 'User haijaingia. Tafadhali ingia kwanza.',
            ], 401);
        }

        $validator = Validator::make($request->all(), [
            'service_id' => 'required|exists:services,id',
            'children' => 'required|integer|min:0',
            'women' => 'required|integer|min:0',
            'men' => 'required|integer|min:0',
            'members' => 'nullable|array',
            'members.*.full_name' => 'required|string',
            'members.*.phone' => 'nullable|string',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => 'error',
                'errors' => $validator->errors(),
            ], 422);
        }

        $total = $request->children + $request->women + $request->men;

        $attendance = Attendance::create([
            'service_id' => $request->service_id,
            'uploaded_by' => $userId,
            'children' => $request->children,
            'women' => $request->women,
            'men' => $request->men,
            'total' => $total,
            'members' => $request->members ?? [],
        ]);

        return response()->json([
            'status' => 'success',
            'message' => 'Mahudhurio yamehifadhiwa kikamilifu.',
            'attendance' => $attendance,
        ]);
    }

    /**
     * Show detailed attendance for a specific service.
     */
    public function show($serviceId)
    {
        $service = Service::with(['attendances.uploader'])->find($serviceId);

        if (!$service) {
            return response()->json([
                'status' => 'error',
                'message' => 'Service haipo.',
            ], 404);
        }

        $attendanceDetails = $service->attendances->map(function ($att) {
            return [
                'id' => $att->id,
                'children' => $att->children,
                'women' => $att->women,
                'men' => $att->men,
                'total' => $att->total,
                'uploaded_by' => $att->uploader?->full_name ?? '-', // safe fallback
                'members' => $att->members,
                'created_at' => $att->created_at,
            ];
        });

        return response()->json([
            'status' => 'success',
            'service' => [
                'id' => $service->id,
                'type' => $service->type,
                'date' => $service->date,
                'attendance' => $attendanceDetails,
            ],
        ]);
    }
}