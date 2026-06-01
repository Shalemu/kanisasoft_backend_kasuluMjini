<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class SmsLog extends Model
{
    protected $fillable = [
        'recipient',
        'receiver',
        'type',
        'message',
        'status',
        'response',
    ];

    protected $casts = [
        'response' => 'array',
    ];
}
