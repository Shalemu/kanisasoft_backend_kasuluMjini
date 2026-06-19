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
            ->assertJsonPath('service_event.duty_leader', 'ANGEL NTELIMI')
            ->assertJsonPath('service_event.total_attendance', 146);

        $this->assertDatabaseHas('service_events', [
            'title' => 'Ibada ya Tatu',
            'service_name' => 'Ibada ya Tatu',
            'preacher' => 'TUMAINI KAAYA',
            'leaders_on_duty' => 'ANGEL NTELIMI',
            'duty_leader' => 'ANGEL NTELIMI',
            'total_attendance' => 146,
        ]);
    }

    public function test_service_event_store_accepts_custom_worship_type_and_duty_leader(): void
    {
        Sanctum::actingAs(User::factory()->create());

        $response = $this->postJson('/api/service-events', [
            'title' => 'Ibada ya Vijana Maalum',
            'service_name' => 'Ibada ya Vijana Maalum',
            'date' => '2026-06-08',
            'preacher' => 'Mhubiri',
            'duty_leader' => 'Kiongozi wa Zamu',
            'attendance_children' => 3,
            'attendance_women' => 4,
            'attendance_men' => 5,
            'total_offerings' => 12345.67,
        ]);

        $response->assertCreated()
            ->assertJsonPath('service_event.title', 'Ibada ya Vijana Maalum')
            ->assertJsonPath('service_event.service_name', 'Ibada ya Vijana Maalum')
            ->assertJsonPath('service_event.leaders_on_duty', 'Kiongozi wa Zamu')
            ->assertJsonPath('service_event.duty_leader', 'Kiongozi wa Zamu')
            ->assertJsonPath('service_event.total_attendance', 12)
            ->assertJsonPath('service_event.total_offerings', 12345.67);
    }

    public function test_service_events_index_filters_and_returns_numeric_fields_with_summary(): void
    {
        Sanctum::actingAs(User::factory()->create());

        ServiceEvent::create([
            'title' => 'Ibada A',
            'service_name' => 'Ibada A',
            'date' => '2026-06-05',
            'preacher' => 'Mhubiri A',
            'attendance_children' => 10,
            'attendance_women' => 20,
            'attendance_men' => 30,
            'total_attendance' => 60,
            'total_offerings' => 1000.50,
        ]);

        ServiceEvent::create([
            'title' => 'Ibada A',
            'service_name' => 'Ibada A',
            'date' => '2026-07-05',
            'preacher' => 'Mhubiri B',
            'attendance_children' => 1,
            'attendance_women' => 2,
            'attendance_men' => 3,
            'total_attendance' => 6,
            'total_offerings' => 200.25,
        ]);

        ServiceEvent::create([
            'title' => 'Ibada B',
            'service_name' => 'Ibada B',
            'date' => '2025-06-05',
            'preacher' => 'Mhubiri C',
            'attendance_children' => 7,
            'attendance_women' => 8,
            'attendance_men' => 9,
            'total_attendance' => 24,
            'total_offerings' => 300,
        ]);

        $response = $this->getJson('/api/service-events?year=2026&service_name=Ibada%20A');

        $response->assertOk()
            ->assertJsonCount(2, 'service_events')
            ->assertJsonPath('summary.total_attendance', 66)
            ->assertJsonPath('summary.total_services', 2)
            ->assertJsonPath('summary.average_attendance', 33)
            ->assertJsonPath('summary.total_offerings', 1200.75);

        $this->assertIsInt($response->json('service_events.0.attendance_children'));
        $this->assertIsInt($response->json('service_events.0.attendance_women'));
        $this->assertIsInt($response->json('service_events.0.attendance_men'));
        $this->assertIsFloat($response->json('service_events.0.total_offerings'));
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
