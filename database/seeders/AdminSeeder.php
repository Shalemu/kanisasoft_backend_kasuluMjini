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
            ['email' => 'lutufyo28@gmail.com'],
            [
                'full_name' => 'System Admin',
                'gender' => 'M',
                'birth_date' => '1990-01-01',
                'birth_place' => 'Dar es Salaam',
                'marital_status' => 'Hajaoa',
                'spouse_name' => null,
                'children_count' => 0,
                'zone' => 'MURUBOMBO',
                'phone' => '255744141430',
                'email' => 'lutufyo28@gmail.com',
                'password' => Hash::make('admin1234'),
                'role' => 'admin',
            ]
        );

    }
}
