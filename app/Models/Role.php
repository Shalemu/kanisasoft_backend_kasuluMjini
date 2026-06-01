<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Role extends Model
{
    use HasFactory;

    protected $fillable = [
        'name',
        'description',
    ];

    /**
     * Optional: A role may have many users (if you're doing role-user relationship).
     */
    public function users()
    {
        return $this->belongsToMany(User::class, 'role_user');
    }
}
