<?php

namespace Tests\Feature;

use App\Models\Group;
use App\Models\Guest;
use App\Models\Member;
use App\Models\ServiceEvent;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Carbon;
use Laravel\Sanctum\Sanctum;
use Tests\TestCase;

class DemoFeedbackApiTest extends TestCase
{
    use RefreshDatabase;

    protected function setUp(): void
    {
        parent::setUp();

        Sanctum::actingAs(User::factory()->create(['role' => 'admin']));
    }

    public function test_dashboard_stats_uses_real_guest_total_and_static_route_resolves(): void
    {
        Guest::create(['full_name' => 'One', 'church_origin' => 'RGCM']);
        Guest::create(['full_name' => 'Two', 'church_origin' => 'RGCM']);

        $this->getJson('/api/members/stats')
            ->assertOk()
            ->assertJsonPath('total_visitors', 2)
            ->assertJsonPath('total_guests', 2);
    }

    public function test_members_are_numerically_ordered_and_report_filters_work(): void
    {
        $this->createMember(['membership_number' => '0010', 'gender' => 'M', 'education_level' => 'Degree']);
        $this->createMember(['membership_number' => '0002', 'gender' => 'F', 'education_level' => 'Certificate']);
        $this->createMember(['membership_number' => '0001', 'gender' => 'F', 'education_level' => 'Degree']);

        $this->getJson('/api/members')
            ->assertOk()
            ->assertJsonPath('members.0.membership_number', '0001')
            ->assertJsonPath('members.1.membership_number', '0002')
            ->assertJsonPath('members.2.membership_number', '0010');

        $this->getJson('/api/members/reports?gender=F&education_level=Degree')
            ->assertOk()
            ->assertJsonPath('total', 1)
            ->assertJsonCount(1, 'members');
    }

    public function test_pending_registration_endpoint_returns_count_and_latest_records(): void
    {
        $pendingUser = User::factory()->create(['role' => null]);
        $this->createMember([
            'user_id' => $pendingUser->id,
            'membership_status' => 'pending',
            'is_authorized' => false,
        ]);
        $this->createMember(['membership_status' => 'active', 'is_authorized' => true]);

        $this->getJson('/api/users/pending-registrations')
            ->assertOk()
            ->assertJsonPath('count', 1)
            ->assertJsonCount(1, 'pending_registrations');
    }

    public function test_approval_fills_smallest_membership_number_gap(): void
    {
        $this->createMember(['membership_number' => '0001']);
        $this->createMember(['membership_number' => '0003']);
        $pendingUser = User::factory()->create(['role' => null]);
        $pending = $this->createMember([
            'user_id' => $pendingUser->id,
            'membership_number' => null,
            'membership_status' => 'pending',
            'is_authorized' => false,
            'phone_number' => null,
            'email' => null,
        ]);

        $this->postJson('/api/authorize-user', ['user_id' => $pendingUser->id])
            ->assertOk()
            ->assertJsonPath('member.membership_number', '0002');

        $this->assertDatabaseHas('members', [
            'id' => $pending->id,
            'membership_number' => '0002',
        ]);
    }

    public function test_member_marriages_can_be_linked_and_listed(): void
    {
        $husband = $this->createMember(['gender' => 'M']);
        $wife = $this->createMember(['gender' => 'F']);

        $response = $this->postJson('/api/member-marriages', [
            'husband_id' => $husband->id,
            'wife_id' => $wife->id,
            'married_at' => '2026-05-01',
        ]);

        $response->assertCreated()
            ->assertJsonPath('marriage.husband_id', $husband->id)
            ->assertJsonPath('marriage.wife_id', $wife->id);

        $this->getJson('/api/member-marriages')
            ->assertOk()
            ->assertJsonCount(1, 'marriages');

        $this->deleteJson('/api/member-marriages/'.$response->json('marriage.id'))->assertOk();
        $this->assertNull($husband->fresh()->spouse_name);
        $this->assertNull($wife->fresh()->spouse_name);
    }

    public function test_guests_return_all_by_default_support_range_and_monthly_stats(): void
    {
        Carbon::setTestNow('2026-06-04');
        Guest::create(['full_name' => 'April', 'church_origin' => 'RGCM', 'visit_date' => '2026-04-30']);
        Guest::create(['full_name' => 'May', 'church_origin' => 'RGCM', 'visit_date' => '2026-05-15']);
        $june = Guest::create(['full_name' => 'June', 'church_origin' => 'RGCM', 'visit_date' => '2026-06-02']);

        $this->getJson('/api/guests')->assertOk()->assertJsonCount(3, 'guests');
        $this->getJson('/api/guests?from_date=2026-05-01&to_date=2026-05-31')
            ->assertOk()
            ->assertJsonCount(1, 'guests')
            ->assertJsonPath('guests.0.full_name', 'May');

        $this->patchJson("/api/guests/{$june->id}", ['other' => null, 'phone' => '255700000000'])
            ->assertOk()
            ->assertJsonPath('guest.phone', '255700000000');

        $this->getJson('/api/guests/stats')
            ->assertOk()
            ->assertJsonPath('total_guests', 3)
            ->assertJsonPath('guests_this_month', 1)
            ->assertJsonPath('guests_last_month', 1);
    }

    public function test_service_events_return_all_by_default_and_can_be_updated(): void
    {
        $first = $this->createServiceEvent(['date' => '2026-05-01']);
        $this->createServiceEvent(['date' => '2026-06-01']);

        $this->getJson('/api/service-events')->assertOk()->assertJsonCount(2, 'service_events');

        $this->patchJson("/api/service-events/{$first->id}", [
            'preacher' => 'Updated Preacher',
            'attendance_men' => 10,
        ])->assertOk()
            ->assertJsonPath('service_event.preacher', 'Updated Preacher')
            ->assertJsonPath('service_event.total_attendance', 10);
    }

    public function test_group_listing_includes_member_count(): void
    {
        $group = Group::create(['name' => 'Youth']);
        $group->members()->attach([
            $this->createMember()->id,
            $this->createMember()->id,
        ]);

        $this->getJson('/api/groups')
            ->assertOk()
            ->assertJsonPath('groups.0.members_count', 2);
    }

    private function createMember(array $attributes = []): Member
    {
        $userId = $attributes['user_id'] ?? User::factory()->create(['role' => 'mshirika'])->id;

        return Member::create(array_merge([
            'user_id' => $userId,
            'full_name' => 'Member '.$userId,
            'gender' => 'M',
            'membership_status' => 'active',
            'membership_number' => null,
            'is_authorized' => true,
        ], $attributes));
    }

    private function createServiceEvent(array $attributes = []): ServiceEvent
    {
        return ServiceEvent::create(array_merge([
            'title' => 'Sunday Worship',
            'service_name' => 'Sunday Worship',
            'date' => '2026-06-04',
            'preacher' => 'Preacher',
            'attendance_children' => 0,
            'attendance_women' => 0,
            'attendance_men' => 0,
            'total_attendance' => 0,
            'total_offerings' => 0,
        ], $attributes));
    }
}
