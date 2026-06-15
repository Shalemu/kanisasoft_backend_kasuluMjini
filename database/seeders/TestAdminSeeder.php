<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\User;
use Illuminate\Support\Facades\Hash;

class TestAdminSeeder extends Seeder
{
    public function run(): void
    {
        User::updateOrCreate(
            ['email' => 'admin@kanisasoft.co.tz'],
            [
                'full_name' => 'Test Admin',
                'gender' => 'M',
                'birth_date' => '1990-01-01',
                'birth_place' => 'Dar es Salaam',
                'marital_status' => 'Hajaoa',
                'spouse_name' => null,
                'children_count' => 0,
                'zone' => 'MURUBOMBO',
                'phone' => '255700000000',
                'email' => 'admin@kanisasoft.co.tz',
                'password' => Hash::make('password123'),
                'role' => 'admin',
            ]
        );
    }
}
