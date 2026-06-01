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
        'date',
        'time',
        'location',
        'category',
        'description',
    ];

    // Cast date and time fields to appropriate types
    protected $casts = [
        'date' => 'date',
        'time' => 'datetime:H:i',
    ];
}
