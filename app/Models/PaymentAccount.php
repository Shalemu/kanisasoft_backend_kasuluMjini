<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class PaymentAccount extends Model
{
    protected $fillable = [
        'name',
        'account_name',
        'account_number',
        'type',
        'logo',
        'instructions',
        'sort_order',
        'is_active',
    ];

    protected $casts = [
        'is_active' => 'boolean',
    ];

    protected $appends = [
        'logo_url',
    ];

    public function getLogoUrlAttribute()
    {
        return $this->logo
            ? asset('storage/' . $this->logo)
            : null;
    }
}