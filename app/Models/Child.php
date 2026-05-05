<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Child extends Model
{
    use HasFactory;

    protected $table = 'children';

    protected $fillable = [
        'child_name',
        'birth_date',
        'gender',
        'parent_name',
        'relationship',
        'phone',
    ];

    protected $casts = [
        'birth_date' => 'date',
    ];

    protected function serializeDate(\DateTimeInterface $date)
    {
        return $date->format('Y-m-d');
    }
}
