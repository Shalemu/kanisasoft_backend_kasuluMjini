<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\User;
use Illuminate\Support\Facades\Hash;

class AdminSeeder extends Seeder
{
    public function run(): void
    {
        $admin = User::where('email', 'support@kanisasoft.co.tz')
            ->orWhere('email', 'lutufyo28@gmail.com')
            ->first();

        ($admin ?? new User())->fill([
            'full_name' => 'KanisaSoft Support',
            'gender' => 'M',
            'birth_date' => '1990-01-01',
            'birth_place' => 'Dar es Salaam',
            'marital_status' => 'Hajaoa',
            'spouse_name' => null,
            'children_count' => 0,
            'zone' => 'MURUBOMBO',
            'phone' => '255744141430',
            'email' => 'support@kanisasoft.co.tz',
            'password' => Hash::make('Admin@2026'),
            'role' => 'admin',
        ])->save();
    }
}
