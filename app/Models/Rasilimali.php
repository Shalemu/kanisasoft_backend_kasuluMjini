<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Storage;

class Rasilimali extends Model
{
    use HasFactory;

    protected $table = 'rasilimali';

    protected $fillable = [
        'title',
        'description',
        'link',
        'file_path',
        'file_type',
        'uploaded_by_id',
        'uploaded_by_role',
    ];

    protected $appends = [
        'file_url',
    ];

    /**
     * Get the full URL for the uploaded file.
     */
    public function getFileUrlAttribute(): ?string
    {
        if (! $this->file_path) {
            return null;
        }

        return Storage::disk('public')->url($this->file_path);
    }

    /**
     * The user who uploaded the resource.
     */
    public function uploader()
    {
        return $this->belongsTo(User::class, 'uploaded_by_id');
    }
}
