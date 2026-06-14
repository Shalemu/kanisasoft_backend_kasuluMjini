<?php

namespace Tests\Feature;

use App\Models\SupportRequest;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\Storage;
use Laravel\Sanctum\Sanctum;
use Tests\TestCase;

class AdminProfileApiTest extends TestCase
{
    use RefreshDatabase;

    public function test_admin_profile_can_update_name_and_upload_profile_picture(): void
    {
        Storage::fake('public');

        $user = User::factory()->create([
            'role' => 'admin',
            'full_name' => 'Old Name',
        ]);

        Sanctum::actingAs($user);

        $response = $this->postJson('/api/admin/profile', [
            'full_name' => 'New Admin Name',
            'profile_picture' => UploadedFile::fake()->create('avatar.jpg', 100, 'image/jpeg'),
        ]);

        $response
            ->assertOk()
            ->assertJsonPath('status', 'success')
            ->assertJsonPath('profile.full_name', 'New Admin Name');

        $user->refresh();

        $this->assertSame('New Admin Name', $user->full_name);
        $this->assertNotNull($user->profile_picture_path);
        Storage::disk('public')->assertExists($user->profile_picture_path);
    }

    public function test_account_settings_are_returned_with_defaults_and_can_be_partially_updated(): void
    {
        $user = User::factory()->create(['role' => 'admin']);
        Sanctum::actingAs($user);

        $this->getJson('/api/admin/account-settings')
            ->assertOk()
            ->assertJsonPath('settings.appearance.theme', 'system')
            ->assertJsonPath('settings.notifications.member_registration_alerts', true);

        $this->patchJson('/api/admin/account-settings', [
            'appearance' => [
                'theme' => 'dark',
            ],
            'dashboard' => [
                'records_per_page' => 50,
            ],
        ])
            ->assertOk()
            ->assertJsonPath('settings.appearance.theme', 'dark')
            ->assertJsonPath('settings.appearance.compact_mode', false)
            ->assertJsonPath('settings.dashboard.records_per_page', 50);
    }

    public function test_support_page_returns_support_options_and_recent_requests(): void
    {
        $user = User::factory()->create(['role' => 'admin']);
        SupportRequest::create([
            'user_id' => $user->id,
            'category' => 'technical',
            'priority' => 'normal',
            'subject' => 'Login issue',
            'message' => 'Unable to load dashboard.',
            'status' => 'open',
        ]);

        Sanctum::actingAs($user);

        $this->getJson('/api/admin/support')
            ->assertOk()
            ->assertJsonPath('status', 'success')
            ->assertJsonPath('support.categories.0', 'account')
            ->assertJsonPath('support.recent_requests.0.subject', 'Login issue');
    }

    public function test_support_request_can_be_created(): void
    {
        $user = User::factory()->create([
            'role' => 'admin',
            'email' => 'admin@example.com',
            'phone' => '255712345678',
        ]);

        Sanctum::actingAs($user);

        $this->postJson('/api/admin/support/requests', [
            'category' => 'members',
            'priority' => 'high',
            'subject' => 'Member import help',
            'message' => 'Please help with a member import issue.',
        ])
            ->assertCreated()
            ->assertJsonPath('support_request.category', 'members')
            ->assertJsonPath('support_request.contact_email', 'admin@example.com');

        $this->assertDatabaseHas('support_requests', [
            'user_id' => $user->id,
            'category' => 'members',
            'priority' => 'high',
            'subject' => 'Member import help',
        ]);
    }
}
