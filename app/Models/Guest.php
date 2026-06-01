<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Guest extends Model
{
    use HasFactory;

    protected $table = 'guests';

    protected $fillable = [
        'full_name',
        'phone',
        'church_origin',
        'visit_date',
        'prayer',
        'salvation',
        'joining',
        'travel',
        'other',
    ];

    protected $casts = [
        'visit_date' => 'date',
        'prayer' => 'boolean',
        'salvation' => 'boolean',
        'joining' => 'boolean',
        'travel' => 'boolean',
    ];

    protected function serializeDate(\DateTimeInterface $date): string
    {
        return $date->format('Y-m-d');
    }
}
