<?php

namespace Tests\Feature;

use App\Models\Group;
use App\Models\Contribution;
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
        Contribution::create([
            'date' => '2026-06-01',
            'type' => 'Sadaka',
            'amount' => 12500,
            'method' => 'Cash',
            'giver_name' => 'Guest Giver',
        ]);

        $this->getJson('/api/members/stats')
            ->assertOk()
            ->assertJsonPath('total_visitors', 2)
            ->assertJsonPath('total_guests', 2)
            ->assertJsonPath('total_contributions', 12500)
            ->assertJsonPath('modules.4.key', 'contributions')
            ->assertJsonPath('modules.4.label', 'Michango')
            ->assertJsonPath('modules.4.icon', 'wallet');
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
            ->assertJsonPath('summary.total_members', 1)
            ->assertJsonPath('export.rows.0.gender', 'F')
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

        $this->getJson('/api/guests?start_date=2026-05-01&end_date=2026-05-31')
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

    public function test_group_details_include_members_leaders_and_total(): void
    {
        $leader = $this->createMember(['membership_number' => '0005']);
        $member = $this->createMember(['membership_number' => '0006']);
        $group = Group::create(['name' => 'Youth', 'leader_id' => $leader->id]);
        $group->members()->attach([$leader->id, $member->id]);

        $this->getJson("/api/groups/{$group->id}")
            ->assertOk()
            ->assertJsonPath('group.name', 'Youth')
            ->assertJsonPath('leaders.0.id', $leader->id)
            ->assertJsonPath('total_members', 2)
            ->assertJsonCount(2, 'members');
    }

    public function test_member_delete_route_soft_deactivates_member(): void
    {
        $member = $this->createMember(['membership_status' => 'active']);

        $this->deleteJson("/api/members/{$member->id}")
            ->assertOk()
            ->assertJsonPath('membership_status', 'deactivated');

        $this->assertDatabaseHas('members', [
            'id' => $member->id,
            'membership_status' => 'deactivated',
            'membership_number' => null,
        ]);
    }

    public function test_deactivated_membership_number_is_reused_on_next_approval(): void
    {
        $first = $this->createMember(['membership_number' => '0001']);
        $this->createMember(['membership_number' => '0002']);

        $this->deleteJson("/api/members/{$first->id}")->assertOk();

        $pendingUser = User::factory()->create(['role' => null]);
        $this->createMember([
            'user_id' => $pendingUser->id,
            'membership_number' => null,
            'membership_status' => 'pending',
            'is_authorized' => false,
            'phone_number' => null,
            'email' => null,
        ]);

        $this->postJson('/api/authorize-user', ['user_id' => $pendingUser->id])
            ->assertOk()
            ->assertJsonPath('member.membership_number', '0001');
    }

    public function test_admin_can_create_member_with_registration_validation(): void
    {
        $response = $this->postJson('/api/admin/members', [
            'full_name' => 'Admin Created',
            'gender' => 'M',
            'birth_date' => '1990-01-01',
            'birth_place' => 'Kigoma',
            'marital_status' => 'Bila ndoa',
            'residential_zone' => 'MURUBOMBO',
            'phone_number' => '0712345678',
            'email' => 'admin-created@example.com',
            'occupation' => 'Teacher',
            'password' => 'secret123',
            'password_confirmation' => 'secret123',
        ]);

        $response
            ->assertCreated()
            ->assertJsonPath('member.membership_status', 'pending')
            ->assertJsonPath('user.phone', '255712345678');
    }

    public function test_contribution_reports_include_totals_exports_and_edit_payload(): void
    {
        $first = Contribution::create([
            'date' => '2026-05-10',
            'type' => 'Fungu la Kumi',
            'amount' => 10000,
            'method' => 'Cash',
            'giver_name' => 'First Giver',
        ]);
        Contribution::create([
            'date' => '2026-06-10',
            'type' => 'Sadaka',
            'amount' => 5000,
            'method' => 'Mobile',
            'giver_name' => 'Second Giver',
        ]);

        $this->getJson('/api/contributions?from_date=2026-05-01&to_date=2026-05-31')
            ->assertOk()
            ->assertJsonPath('summary.total_contributions', 10000)
            ->assertJsonPath('summary.total_records', 1)
            ->assertJsonPath('export.rows.0.giver', 'First Giver');

        $this->getJson("/api/contributions/{$first->id}")
            ->assertOk()
            ->assertJsonPath('edit_data.giver_name', 'First Giver');

        $this->patchJson("/api/contributions/{$first->id}", ['amount' => 12000])
            ->assertOk()
            ->assertJsonPath('contribution.amount', 12000);
    }

    public function test_contribution_frontend_contract_aliases_work(): void
    {
        $response = $this->postJson('/api/contributions', [
            'contribution_date' => '2026-06-06',
            'amount' => 50000,
            'category' => 'Sadaka',
            'payment_method' => 'Cash',
            'donor_name' => 'Optional name',
            'reference' => 'REF-001',
            'notes' => 'Optional notes',
        ]);

        $response->assertOk()
            ->assertJsonPath('status', 'success')
            ->assertJsonPath('contribution.date', '2026-06-06')
            ->assertJsonPath('contribution.contribution_date', '2026-06-06')
            ->assertJsonPath('contribution.amount', 50000)
            ->assertJsonPath('contribution.type', 'Sadaka')
            ->assertJsonPath('contribution.category', 'Sadaka')
            ->assertJsonPath('contribution.payment_method', 'Cash')
            ->assertJsonPath('contribution.donor_name', 'Optional name')
            ->assertJsonPath('contribution.reference', 'REF-001')
            ->assertJsonPath('contribution.notes', 'Optional notes');

        $id = $response->json('contribution.id');

        $this->getJson('/api/contributions?start_date=2026-06-01&end_date=2026-06-30&type=Sadaka&payment_method=Cash')
            ->assertOk()
            ->assertJsonPath('status', 'success')
            ->assertJsonCount(1, 'contributions')
            ->assertJsonPath('contributions.0.id', $id)
            ->assertJsonPath('contributions.0.donor_name', 'Optional name');

        $this->deleteJson("/api/contributions/{$id}")
            ->assertOk()
            ->assertJsonPath('status', 'success')
            ->assertJsonPath('message', 'Contribution deleted successfully');
    }

    public function test_invalid_sms_phone_returns_clear_error_and_logs_failure(): void
    {
        $this->postJson('/api/send-sms', [
            'phone' => '12345',
            'message' => 'Test message',
            'name' => 'Bad Phone',
        ])
            ->assertStatus(422)
            ->assertJsonPath('status', 'error');

        $this->assertDatabaseHas('sms_logs', [
            'recipient' => '12345',
            'status' => 'Failed',
        ]);
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
