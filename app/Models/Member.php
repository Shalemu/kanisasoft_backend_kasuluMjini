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
        'birth_region',
        'birth_district',
        'birth_ward',
        'birth_street',
        'marital_status',
        'marriage_type',
        'spouse_name',
        'number_of_children',
        'residential_zone',
        'residential_ward',
        'residential_street',
        'phone_number',
        'whatsapp_number',
        'email',
        'has_disability',
        'disability_description',

        // Imani
        'date_of_conversion',
        'conversion_year',
        'conversion_month',
        'conversion_day',
        'church_of_conversion',
        'baptism_date',
        'baptism_year',
        'baptism_month',
        'baptism_day',
        'baptism_place',
        'baptizer_name',
        'baptizer_title',
        'previous_church',
        'previous_church_status',
        'tangu_lini',
        'church_service',
        'service_duration',
        'participates_communion',

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
        'has_disability' => 'boolean',
        'participates_communion' => 'boolean',
        'conversion_year' => 'integer',
        'conversion_month' => 'integer',
        'conversion_day' => 'integer',
        'baptism_year' => 'integer',
        'baptism_month' => 'integer',
        'baptism_day' => 'integer',
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
