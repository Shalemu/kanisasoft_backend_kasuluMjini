<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ChurchInformation extends Model
{

    protected $fillable = [

        'church_name',
        'about',
        'history',
        'phone',
        'email',
        'website',
        'facebook',
        'instagram',
        'youtube',
        'whatsapp',
        'address',
        'latitude',
        'longitude',
        'map_link',
        'image',
        'slug',
        'is_active',
        'created_by',
        'updated_by',

    ];


    protected $casts = [

        'is_active'=>'boolean',

        'latitude'=>'decimal:7',
        'longitude'=>'decimal:7',

    ];


    public function creator()
    {
        return $this->belongsTo(User::class,'created_by');
    }

}