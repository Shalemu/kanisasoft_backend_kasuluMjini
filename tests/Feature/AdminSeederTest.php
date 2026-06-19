<?php

namespace Tests\Feature;

use App\Models\User;
use Database\Seeders\AdminSeeder;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\Hash;
use Tests\TestCase;

class AdminSeederTest extends TestCase
{
    use RefreshDatabase;

    public function test_admin_seeder_creates_requested_support_admin_credentials(): void
    {
        $this->seed(AdminSeeder::class);

        $admin = User::where('email', 'support@kanisasoft.co.tz')->firstOrFail();

        $this->assertSame('KanisaSoft Support', $admin->full_name);
        $this->assertSame('admin', $admin->role);
        $this->assertTrue(Hash::check('Admin@2026', $admin->password));
    }

    public function test_admin_seeder_updates_previous_seeded_admin_email(): void
    {
        User::factory()->create([
            'email' => 'lutufyo28@gmail.com',
            'phone' => '255744141430',
            'role' => 'admin',
        ]);

        $this->seed(AdminSeeder::class);

        $this->assertDatabaseMissing('users', ['email' => 'lutufyo28@gmail.com']);
        $admin = User::where('email', 'support@kanisasoft.co.tz')->firstOrFail();

        $this->assertSame('admin', $admin->role);
        $this->assertTrue(Hash::check('Admin@2026', $admin->password));
    }
}
