<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class LeadershipRole extends Model
{
    use HasFactory;

    protected $fillable = [
        'title',
        'requires_member',
        'is_protected',
    ];

    /**
     * A leadership role can belong to many leaders (many-to-many)
     */
    public function leaders()
    {
        return $this->belongsToMany(
            Leader::class,
            'leader_leadership_role',   // pivot table
            'leadership_role_id',       // THIS model key in pivot ✅
            'leader_id'                 // related model key
        )->withTimestamps();
    }
}
