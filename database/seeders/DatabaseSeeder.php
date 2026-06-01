<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\User;

class DatabaseSeeder extends Seeder
{
    public function run(): void
    {
        // Create test user manually without factory
        // User::create([
        //     'name' => 'Test User',
        //     'email' => 'test@example.com',
        //     'password' => bcrypt('password'),
        // ]);

        $this->call([
            AdminSeeder::class,
            ContributionTypeSeeder::class,
            LeadershipRolesSeeder::class,
        ]);
    }
}
