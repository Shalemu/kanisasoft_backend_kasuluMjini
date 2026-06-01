<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class DeletedMember extends Model
{
    protected $fillable = [
        'user_id',
        'full_name',
        'email',
        'phone',
        'gender',
        'birth_date',
        'reason',
        'deleted_by',
    ];
}
