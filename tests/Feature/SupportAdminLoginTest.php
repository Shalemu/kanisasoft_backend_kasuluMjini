<?php

namespace Tests\Feature;

use Database\Seeders\AdminSeeder;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class SupportAdminLoginTest extends TestCase
{
    use RefreshDatabase;

    public function test_support_admin_can_login_and_receive_sanctum_token(): void
    {
        $this->seed(AdminSeeder::class);

        $response = $this->postJson('/api/login', [
            'login' => 'support@kanisasoft.co.tz',
            'password' => 'Admin@2026',
        ]);

        $response
            ->assertOk()
            ->assertJsonPath('status', 'success')
            ->assertJsonPath('user.email', 'support@kanisasoft.co.tz')
            ->assertJsonStructure([
                'token',
            ]);

        $this->assertDatabaseCount('personal_access_tokens', 1);
    }
}
