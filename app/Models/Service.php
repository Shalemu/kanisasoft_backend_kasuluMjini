<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ServiceEvent extends Model
{
    use HasFactory;

    protected $fillable = [
        'date',
        'service_name',
        'preacher',
        'message',
        'attendance_women',
        'attendance_men',
        'attendance_children',
        'total_offerings',
        'leaders_on_duty',
    ];
}