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
    ];

    protected $casts = [
        'date' => 'date',
        'time' => 'datetime:H:i',
    ];
}
