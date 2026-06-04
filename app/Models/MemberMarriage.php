<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class MemberMarriage extends Model
{
    use HasFactory;

    protected $fillable = [
        'husband_id',
        'wife_id',
        'married_at',
    ];

    protected $casts = [
        'married_at' => 'date',
    ];

    public function husband()
    {
        return $this->belongsTo(Member::class, 'husband_id');
    }

    public function wife()
    {
        return $this->belongsTo(Member::class, 'wife_id');
    }
}
