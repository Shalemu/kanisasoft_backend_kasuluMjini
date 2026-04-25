<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\User;
use Illuminate\Support\Facades\Hash;

class AdminSeeder extends Seeder
{
    public function run(): void
    {
        User::updateOrCreate(
    ['email' => 'admin@kanisasoft.com'],
    [
        'full_name' => 'System Admin',
        'gender' => 'M',
        'birth_date' => '1990-01-01',
        'birth_place' => 'Dar es Salaam',
        'marital_status' => 'Hajaoa',
        'spouse_name' => null,
        'children_count' => 0,
        'zone' => 'Admin',
        'phone' => '0700000000',
        'email' => 'admin@kanisasoft.com',
        'password' => Hash::make('admin1234'),
        'role' => 'admin',
    ]
);

    }
}
