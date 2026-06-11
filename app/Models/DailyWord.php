<?php

namespace App\Models;

use DateTimeInterface;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DailyWord extends Model
{
    use HasFactory;

    protected $fillable = [
        'scheduled_date',
        'scripture_reference',
        'verse_text',
        'explanation',
        'author_name',
        'created_by',
    ];

    protected $casts = [
        'scheduled_date' => 'date',
    ];

    protected function serializeDate(DateTimeInterface $date)
    {
        return $date->format('Y-m-d');
    }

    public function author()
    {
        return $this->belongsTo(User::class, 'created_by');
    }
}
