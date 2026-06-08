<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Event extends Model
{
    use HasFactory;

    // Fields that can be mass-assigned
    protected $fillable = [
        'title',
        'type',
        'date',
        'start_date',
        'end_date',
        'time',
        'start_time',
        'location',
        'category',
        'description',
        'audience_group_ids',
    ];

    // Cast date and time fields to appropriate types
    protected $casts = [
        'date' => 'date',
        'start_date' => 'date',
        'end_date' => 'date',
        'audience_group_ids' => 'array',
    ];

    protected function serializeDate(\DateTimeInterface $date)
    {
        return $date->format('Y-m-d');
    }
}
