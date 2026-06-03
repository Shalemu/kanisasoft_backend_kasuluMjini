<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Service;

class ServiceController extends Controller
{
    public function store(Request $request)
    {
        $request->validate([
            'type' => 'required|string',
            'date' => 'required|date',
        ]);

        $service = Service::create($request->only('type','date'));

        return response()->json([
            'status' => 'success',
            'service' => $service
        ]);
    }
}