<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Leader extends Model
{
    use HasFactory;

    protected $fillable = [
        'leader_code',
        'full_name',
        'phone',
        'email',
        'user_id',
        'status',
    ];

    /**
     * Auto-generate leader_code when creating a leader
     */
    protected static function booted()
    {
        static::creating(function ($leader) {
            if (empty($leader->leader_code)) {
                $leader->leader_code = 'LEAD-' . uniqid();
            }
        });
    }

    /**
     * A leader can have many leadership roles (many-to-many)
     */
    public function roles()
    {
        return $this->belongsToMany(
            LeadershipRole::class,
            'leader_leadership_role',   // pivot table
            'leader_id',                // THIS model key in pivot
            'leadership_role_id'        // related model key
        )->withTimestamps();
    }

    /**
     * The user assigned to this leader
     */
    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
