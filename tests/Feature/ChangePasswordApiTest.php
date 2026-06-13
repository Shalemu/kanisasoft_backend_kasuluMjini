<?php

namespace Tests\Feature;

use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\Hash;
use Laravel\Sanctum\Sanctum;
use Tests\TestCase;

class ChangePasswordApiTest extends TestCase
{
    use RefreshDatabase;

    public function test_change_password_requires_authentication(): void
    {
        $this->postJson('/api/user/change-password', [
            'current_password' => 'Oldpass1!',
            'new_password' => 'Newpass1!',
            'new_password_confirmation' => 'Newpass1!',
        ])->assertUnauthorized();
    }

    public function test_change_password_validates_required_fields(): void
    {
        Sanctum::actingAs(User::factory()->create());

        $this->postJson('/api/user/change-password', [])
            ->assertUnprocessable()
            ->assertJsonValidationErrors([
                'current_password',
                'new_password',
                'new_password_confirmation',
            ]);
    }

    public function test_change_password_validates_confirmation_strength_and_difference(): void
    {
        $user = User::factory()->create([
            'password' => Hash::make('Oldpass1!'),
        ]);

        Sanctum::actingAs($user);

        $this->postJson('/api/user/change-password', [
            'current_password' => 'Oldpass1!',
            'new_password' => 'Oldpass1!',
            'new_password_confirmation' => 'Different1!',
        ])
            ->assertUnprocessable()
            ->assertJsonValidationErrors([
                'new_password',
                'new_password_confirmation',
            ]);

        $this->assertTrue(Hash::check('Oldpass1!', $user->fresh()->password));
    }

    public function test_change_password_rejects_weak_new_passwords(): void
    {
        $user = User::factory()->create([
            'password' => Hash::make('Oldpass1!'),
        ]);

        Sanctum::actingAs($user);

        $this->postJson('/api/user/change-password', [
            'current_password' => 'Oldpass1!',
            'new_password' => 'abcdef',
            'new_password_confirmation' => 'abcdef',
        ])
            ->assertUnprocessable()
            ->assertJsonValidationErrors(['new_password']);

        $this->assertTrue(Hash::check('Oldpass1!', $user->fresh()->password));
    }

    public function test_change_password_rejects_wrong_current_password_without_changing_password(): void
    {
        $user = User::factory()->create([
            'password' => Hash::make('Oldpass1!'),
        ]);

        Sanctum::actingAs($user);

        $this->postJson('/api/user/change-password', [
            'current_password' => 'Wrongpass1!',
            'new_password' => 'Newpass1!',
            'new_password_confirmation' => 'Newpass1!',
        ])
            ->assertUnprocessable()
            ->assertJsonValidationErrors(['current_password'])
            ->assertJsonPath('errors.current_password.0', 'Password ya sasa si sahihi.');

        $this->assertTrue(Hash::check('Oldpass1!', $user->fresh()->password));
    }

    public function test_authenticated_user_can_change_password(): void
    {
        $user = User::factory()->create([
            'password' => Hash::make('Oldpass1!'),
        ]);

        Sanctum::actingAs($user);

        $this->postJson('/api/user/change-password', [
            'current_password' => 'Oldpass1!',
            'new_password' => 'Newpass1!',
            'new_password_confirmation' => 'Newpass1!',
        ])
            ->assertOk()
            ->assertExactJson([
                'status' => 'success',
                'message' => 'Password imebadilishwa kikamilifu. Tafadhali ingia tena.',
            ]);

        $this->assertTrue(Hash::check('Newpass1!', $user->fresh()->password));
    }
}
