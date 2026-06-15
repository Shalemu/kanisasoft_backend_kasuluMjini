<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Storage;

class Invoice extends Model
{
    use HasFactory;

    protected $fillable = [
        'title',
        'file_path',
        'file_type',
        'uploaded_by_id',
        'uploaded_by_role',
    ];

    protected $appends = [
        'file_url',
    ];

    public function getFileUrlAttribute(): ?string
    {
        if (! $this->file_path) {
            return null;
        }

        return Storage::disk('public')->url($this->file_path);
    }

    public function uploader()
    {
        return $this->belongsTo(User::class, 'uploaded_by_id');
    }
}
