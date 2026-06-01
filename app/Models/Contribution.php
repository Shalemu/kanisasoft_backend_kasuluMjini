<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\Models\User;

class Contribution extends Model
{
    protected $fillable = [
        'date',
        'type',
        'amount',
        'method',
        'user_id',
        'giver_name',
    ];

    protected $casts = [
        'date' => 'date',
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function getGiverAttribute()
    {
        return $this->user?->full_name ?? $this->giver_name ?? 'Haijulikani';
    }
}
