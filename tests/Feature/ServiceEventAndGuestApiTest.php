<?php

namespace Tests\Feature;

use App\Models\Guest;
use App\Models\ServiceEvent;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Laravel\Sanctum\Sanctum;
use Tests\TestCase;

class ServiceEventAndGuestApiTest extends TestCase
{
    use RefreshDatabase;

    public function test_service_event_store_accepts_frontend_alias_fields(): void
    {
        Sanctum::actingAs(User::factory()->create());

        $response = $this->postJson('/api/service-events', [
            'date' => '2026-06-04',
            'service_type' => 'Ibada ya Tatu',
            'mhubiri' => 'TUMAINI KAAYA',
            'mahubiri' => 'MAHUBIRI YA ASUBUHI',
            'leader' => 'ANGEL NTELIMI',
            'children' => 45,
            'women' => 52,
            'men' => 49,
            'sadaka' => 235000,
            'ujumbe' => 'Ilikuwa ibada njema sana',
        ]);

        $response->assertCreated()
            ->assertJsonPath('service_event.title', 'Ibada ya Tatu')
            ->assertJsonPath('service_event.service_name', 'Ibada ya Tatu')
            ->assertJsonPath('service_event.preacher', 'TUMAINI KAAYA')
            ->assertJsonPath('service_event.total_attendance', 146);

        $this->assertDatabaseHas('service_events', [
            'title' => 'Ibada ya Tatu',
            'service_name' => 'Ibada ya Tatu',
            'preacher' => 'TUMAINI KAAYA',
            'leaders_on_duty' => 'ANGEL NTELIMI',
            'total_attendance' => 146,
        ]);
    }

    public function test_service_event_show_returns_edit_payload(): void
    {
        Sanctum::actingAs(User::factory()->create());

        $event = ServiceEvent::create([
            'title' => 'Ibada ya Pili',
            'service_name' => 'Ibada ya Pili',
            'date' => '2026-06-05',
            'preacher' => 'Mhubiri',
        ]);

        $this->getJson("/api/service-events/{$event->id}")
            ->assertOk()
            ->assertJsonPath('service_event.id', $event->id)
            ->assertJsonPath('edit_data.title', 'Ibada ya Pili')
            ->assertJsonPath('edit_data.service_name', 'Ibada ya Pili');
    }

    public function test_guests_index_filters_by_date_and_returns_summary(): void
    {
        Sanctum::actingAs(User::factory()->create());

        Guest::create([
            'full_name' => 'Guest One',
            'church_origin' => 'RGCM',
            'visit_date' => '2026-06-03',
            'prayer' => true,
        ]);

        Guest::create([
            'full_name' => 'Guest Two',
            'church_origin' => 'RGCM',
            'visit_date' => '2026-06-04',
            'prayer' => false,
        ]);

        $response = $this->getJson('/api/guests?date=2026-06-03');

        $response->assertOk()
            ->assertJsonPath('summary.total_guests', 1)
            ->assertJsonPath('summary.total_prayer', 1)
            ->assertJsonCount(1, 'guests')
            ->assertJsonPath('guests.0.full_name', 'Guest One');
    }

    public function test_guest_show_returns_edit_payload(): void
    {
        Sanctum::actingAs(User::factory()->create());

        $guest = Guest::create([
            'full_name' => 'Guest One',
            'church_origin' => 'RGCM',
            'visit_date' => '2026-06-03',
            'prayer' => true,
        ]);

        $this->getJson("/api/guests/{$guest->id}")
            ->assertOk()
            ->assertJsonPath('guest.id', $guest->id)
            ->assertJsonPath('edit_data.full_name', 'Guest One')
            ->assertJsonPath('edit_data.prayer', true);
    }
}
