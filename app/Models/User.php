<?php

namespace App\Models;

use Illuminate\Auth\MustVerifyEmail;
use Illuminate\Contracts\Auth\MustVerifyEmail as MustVerifyEmailContract;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;
use DateTimeInterface;
use App\Notifications\ResetPasswordNotification;

class User extends Authenticatable implements MustVerifyEmailContract
{
    use HasApiTokens, HasFactory, MustVerifyEmail, Notifiable;

    protected $table = 'users';

    protected $fillable = [
        'full_name',
        'gender',
        'birth_date',
        'birth_place',
        'birth_region',
        'birth_district',
        'birth_ward',
        'birth_street',
        'marital_status',
        'marriage_type',
        'spouse_name',
        'children_count',
        'zone',
        'residential_ward',
        'residential_street',
        'phone',
        'whatsapp_number',
        'email',
        'has_disability',
        'disability_description',
        'password',
        'role', // SYSTEM role only (admin | kiongozi | mshirika)
        'profile_picture_path',
    ];

    protected $hidden = [
        'password',
        'remember_token',
    ];

    protected $appends = [
        'profile_picture_url',
    ];

    protected $casts = [
        'birth_date' => 'date',
        'children_count' => 'integer',
        'email_verified_at' => 'datetime',
        'has_disability' => 'boolean',
    ];

    protected function serializeDate(DateTimeInterface $date)
    {
        return $date->format('Y-m-d');
    }

    public function getProfilePictureUrlAttribute(): ?string
    {
        if (! $this->profile_picture_path) {
            return null;
        }

        $path = ltrim($this->profile_picture_path, '/');

        if (str_starts_with($path, 'storage/')) {
            return url($path);
        }

        return url('storage/' . $path);
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


public function setRoleAttribute(?string $value)
{
    // allow pending users (NULL role)
    if (is_null($value)) {
        $this->attributes['role'] = null;
        return;
    }

    // protect admin role from being overwritten
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
