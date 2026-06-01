<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ContributionType extends Model
{
    protected $table = 'contribution_types';

    protected $fillable = ['name'];

    public function contributions()
    {
        return $this->hasMany(Contribution::class, 'type', 'name');
    }
}
