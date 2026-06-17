<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\Models\User;

class Contribution extends Model
{
    protected $fillable = [
        'date',
        'contribution_date',
        'type',
        'category',
        'amount',
        'method',
        'payment_method',
        'user_id',
        'giver_name',
        'donor_name',
        'member_id',
        'member_name',
        'membership_number',
        'pledge_amount',
        'total_paid',
        'reference',
        'notes',
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
