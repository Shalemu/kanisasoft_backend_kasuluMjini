<?php

namespace App\Models;

use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;
use DateTimeInterface;
use App\Notifications\ResetPasswordNotification;

class User extends Authenticatable
{
    use HasApiTokens, Notifiable;

    protected $table = 'users';

    protected $fillable = [
        'full_name',
        'gender',
        'birth_date',
        'birth_place',
        'birth_district',
        'marital_status',
        'spouse_name',
        'children_count',
        'zone',
        'phone',
        'whatsapp_number',
        'email',
        'password',
        'role', // SYSTEM role only (admin | kiongozi | mshirika)
    ];

    protected $hidden = [
        'password',
        'remember_token',
    ];

    protected $casts = [
        'birth_date' => 'date',
        'children_count' => 'integer',
        'email_verified_at' => 'datetime',
    ];

    protected function serializeDate(DateTimeInterface $date)
    {
        return $date->format('Y-m-d');
    }

    // -------------------------
    // Relationships
    // -------------------------

    /**
     * A user may have multiple leader records (for multiple positions)
     */
    public function leaders()
    {
        return $this->hasMany(Leader::class);
    }

    /**
     * Optional backward compatibility: first leader
     */
    public function leader()
    {
        return $this->hasOne(Leader::class);
    }

    /**
     * A user may be a church member
     */
    public function member()
    {
        return $this->hasOne(Member::class);
    }

    /**
     * All leadership roles of this user across all leaders
     */
    public function roles()
    {
        return $this->leaders->flatMap(fn($leader) => $leader->roles)->unique('id');
    }

    // -------------------------
    // Helper Methods
    // -------------------------

    /**
     * Convenient accessor
     * Allows $user->roles to be used like a normal attribute
     */
    public function getRolesAttribute()
    {
        return $this->roles();
    }

    /**
     * Check system role (admin | kiongozi | mshirika)
     */
    public function hasSystemRole(string $role): bool
    {
        return $this->role === $role;
    }

    /**
     * Check if user has a specific leadership role
     */
    public function hasLeadershipRole(string $roleTitle): bool
    {
        return $this->roles()->contains('title', $roleTitle);
    }

    /**
     * Send password reset notification
     */
    public function sendPasswordResetNotification($token)
    {
        $this->notify(new ResetPasswordNotification($token));
    }


    public function setRoleAttribute($value)
{
    if (
        isset($this->attributes['role']) &&
        $this->attributes['role'] === 'admin' &&
        $value !== 'admin'
    ) {
        return;
    }

    $this->attributes['role'] = $value;
}

}
