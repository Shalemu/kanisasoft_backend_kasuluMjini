<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\Models\User;

class Preaching extends Model
{

    protected $fillable = [
        'date',
        'preacher_name',
        'title',
        'description',
        'pdf_file',
        'video_link',
        'is_active',
        'created_by',
        'updated_by',
    ];


    protected $casts = [
        'date' => 'date',
        'is_active' => 'boolean',
    ];


    public function creator()
    {
        return $this->belongsTo(User::class,'created_by');
    }

}