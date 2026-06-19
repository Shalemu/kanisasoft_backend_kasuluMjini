<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ServiceEvent extends Model
{
    use HasFactory;

    protected $table = 'service_events';

    protected $fillable = [
        'title',
        'date',
        'time',
        'location',
        'category',
        'description',
        'service_name',
        'preacher',
        'preacher_description',
        'message',
        'attendance_children',
        'attendance_women',
        'attendance_men',
        'total_attendance',
        'total_offerings',
        'leaders_on_duty',
        'duty_leader',
    ];

    protected $casts = [
        'date' => 'date',
        'time' => 'datetime:H:i',
        'attendance_children' => 'integer',
        'attendance_women' => 'integer',
        'attendance_men' => 'integer',
        'total_attendance' => 'integer',
        'total_offerings' => 'float',
    ];
}
