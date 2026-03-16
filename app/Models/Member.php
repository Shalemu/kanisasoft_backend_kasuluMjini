<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Member extends Model
{
    use HasFactory;

    protected $table = 'members';

    protected $fillable = [
        'user_id',
        'full_name',
        'gender',
        'birth_date',
        'birth_place',
        'birth_district',
        'marital_status',
        'spouse_name',
        'number_of_children',
        'residential_zone',
        'phone_number',
         'whatsapp_number',
        'email',

        // Imani
        'date_of_conversion',
        'church_of_conversion',
        'baptism_date',
        'baptism_place',
        'baptizer_name',
        'baptizer_title',
        'previous_church',
        'previous_church_status',
        'tangu_lini',
        'church_service',
        'service_duration',

        // Elimu
        'education_level',
        'profession',
        'occupation',
        'work_place',
        'work_contact',

        // Familia
        'lives_alone',
        'lives_with',
        'family_role',
        'live_with_who',
        'next_of_kin',
        'next_of_kin_phone',

        // Membership info
        'membership_number',
        'verified_by',
        'membership_start_date',
        'membership_status',
        'deactivation_reason',
        'is_authorized',
    ];


    protected function serializeDate(\DateTimeInterface $date)
{
    return $date->format('Y-m-d');
}


    protected $casts = [
        'birth_date' => 'date',
        'date_of_conversion' => 'date',
        'baptism_date' => 'date',
        'membership_start_date' => 'date',
        'lives_alone' => 'boolean',
    ];

    /**
     * Many-to-many relationship with groups.
     */
    public function groups()
    {
        return $this->belongsToMany(Group::class, 'member_group', 'member_id', 'group_id')
                    ->withTimestamps();
    }

    /**
     * Link to the user account.
     */
    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
