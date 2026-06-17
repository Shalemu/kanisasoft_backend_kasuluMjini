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
        'invoice_number',
        'invoice_date',
        'due_date',
        'sub_total',
        'credit',
        'total',
        'status',
        'transactions',
        'file_path',
        'file_type',
        'uploaded_by_id',
        'uploaded_by_role',
    ];

    protected $appends = [
        'file_url',
    ];

    protected $casts = [
        'invoice_date' => 'date',
        'due_date' => 'date',
        'sub_total' => 'decimal:2',
        'credit' => 'decimal:2',
        'total' => 'decimal:2',
        'transactions' => 'array',
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
