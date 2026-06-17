<?php

namespace Tests\Feature;

use App\Models\Group;
use App\Models\Contribution;
use App\Models\Event;
use App\Models\Guest;
use App\Models\Member;
use App\Models\ServiceEvent;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\Http;
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

    public function test_member_search_filter_uses_registration_fields_and_can_create_group(): void
    {
        $leader = $this->createMember(['membership_number' => '0007']);
        $matched = $this->createMember([
            'full_name' => 'Matched Husband',
            'gender' => 'M',
            'marital_status' => 'Ameoa',
            'residential_zone' => 'MURUBOMBO',
            'education_level' => 'Degree',
            'occupation' => 'Teacher',
            'has_disability' => false,
            'previous_church' => 'RGCM Kigoma',
            'membership_status' => 'active',
        ]);
        $this->createMember([
            'full_name' => 'Different Member',
            'gender' => 'F',
            'marital_status' => 'Hajaolewa',
            'residential_zone' => 'KIGANAMO',
            'education_level' => 'Certificate',
            'occupation' => 'Nurse',
            'previous_church' => 'Other Church',
            'membership_status' => 'active',
        ]);

        $query = http_build_query([
            'gender' => 'Mwanaume',
            'marital_status' => 'Ameoa',
            'residential_zone' => 'MURUBOMBO',
            'education_level' => 'Degree',
            'search' => 'RGCM',
        ]);

        $this->getJson('/api/members/search-filter?'.$query)
            ->assertOk()
            ->assertJsonPath('total', 1)
            ->assertJsonPath('members.0.id', $matched->id)
            ->assertJsonPath('filters.gender', 'M')
            ->assertJsonPath('saved_group_criteria.gender', 'M')
            ->assertJsonPath('export.rows.0.occupation', 'Teacher');

        $response = $this->postJson('/api/members/search-filter/groups', [
            'name' => 'Wanaume Waliooa',
            'leader_membership_number' => '0007',
            'whatsapp_link' => 'https://chat.whatsapp.com/example',
            'gender' => 'Mwanaume',
            'marital_status' => 'Ameoa',
            'residential_zone' => 'MURUBOMBO',
            'education_level' => 'Degree',
            'search' => 'RGCM',
        ]);

        $groupId = $response->assertCreated()
            ->assertJsonPath('assigned_members_count', 1)
            ->assertJsonPath('group.name', 'Wanaume Waliooa')
            ->assertJsonPath('group.leader_id', $leader->id)
            ->assertJsonPath('filter_criteria.gender', 'M')
            ->json('group.id');

        $this->assertDatabaseHas('member_group', [
            'group_id' => $groupId,
            'member_id' => $matched->id,
        ]);
        $this->assertDatabaseHas('groups', [
            'id' => $groupId,
            'name' => 'Wanaume Waliooa',
        ]);
    }

    public function test_member_search_filter_matches_normalized_membership_number(): void
    {
        $matched = $this->createMember([
            'full_name' => 'Zero Padded Member',
            'membership_number' => '0043',
        ]);
        $this->createMember([
            'full_name' => 'Other Member',
            'membership_number' => '0012',
        ]);

        $this->getJson('/api/members/search-filter?search=43')
            ->assertOk()
            ->assertJsonPath('total', 1)
            ->assertJsonPath('members.0.id', $matched->id)
            ->assertJsonPath('members.0.membership_number', '0043');
    }

    public function test_group_can_be_created_with_leader_member_id_or_unique_leader_name(): void
    {
        $leaderById = $this->createMember([
            'full_name' => 'Leader By Id',
            'membership_number' => '0021',
        ]);
        $leaderByName = $this->createMember([
            'full_name' => 'Unique Leader Name',
            'membership_number' => '0022',
        ]);
        $matched = $this->createMember([
            'full_name' => 'Matched Active Member',
            'gender' => 'F',
            'membership_status' => 'active',
        ]);

        $this->postJson('/api/members/search-filter/groups', [
            'name' => 'Leader Id Group',
            'leader_member_id' => $leaderById->id,
            'gender' => 'Mwanamke',
        ])
            ->assertCreated()
            ->assertJsonPath('group.leader_id', $leaderById->id)
            ->assertJsonPath('assigned_members_count', 1);

        $this->postJson('/api/members/search-filter/groups', [
            'name' => 'Leader Name Group',
            'leader_name' => 'Unique Leader',
            'gender' => 'Mwanamke',
        ])
            ->assertCreated()
            ->assertJsonPath('group.leader_id', $leaderByName->id)
            ->assertJsonPath('assigned_members_count', 1);

        $this->assertDatabaseHas('member_group', [
            'member_id' => $matched->id,
        ]);
    }

    public function test_group_creation_requires_specific_member_when_leader_name_matches_multiple_members(): void
    {
        $this->createMember(['full_name' => 'Duplicate Leader One']);
        $this->createMember(['full_name' => 'Duplicate Leader Two']);
        $this->createMember([
            'full_name' => 'Matched Active Member',
            'gender' => 'M',
            'membership_status' => 'active',
        ]);

        $this->postJson('/api/members/search-filter/groups', [
            'name' => 'Ambiguous Leader Group',
            'leader_name' => 'Duplicate Leader',
            'gender' => 'Mwanaume',
        ])
            ->assertUnprocessable()
            ->assertJsonPath('status', 'error')
            ->assertJsonCount(2, 'matches');
    }

    public function test_users_search_matches_name_and_normalized_membership_number_with_required_identifiers(): void
    {
        $matchedByNumberUser = User::factory()->create([
            'full_name' => 'Number Search User',
            'role' => 'mshirika',
        ]);
        $matchedByNumber = $this->createMember([
            'user_id' => $matchedByNumberUser->id,
            'full_name' => 'Number Search Member',
            'membership_number' => '0043',
        ]);
        $matchedByNameUser = User::factory()->create([
            'full_name' => 'Name Search User',
            'role' => 'mshirika',
        ]);
        $matchedByName = $this->createMember([
            'user_id' => $matchedByNameUser->id,
            'full_name' => 'Alpha Search Member',
            'membership_number' => '0099',
        ]);

        $this->getJson('/api/users?search=43')
            ->assertOk()
            ->assertJsonFragment([
                'id' => $matchedByNumberUser->id,
                'user_id' => $matchedByNumberUser->id,
                'member_id' => $matchedByNumber->id,
                'full_name' => 'Number Search Member',
                'membership_number' => '0043',
            ]);

        $this->getJson('/api/users?search=Alpha')
            ->assertOk()
            ->assertJsonFragment([
                'user_id' => $matchedByNameUser->id,
                'member_id' => $matchedByName->id,
                'full_name' => 'Alpha Search Member',
                'membership_number' => '0099',
            ]);
    }

    public function test_approved_member_is_auto_assigned_to_matching_filtered_group(): void
    {
        $existing = $this->createMember([
            'gender' => 'M',
            'marital_status' => 'Ameoa',
            'residential_zone' => 'MURUBOMBO',
            'education_level' => 'Degree',
            'membership_status' => 'active',
        ]);

        $groupId = $this->postJson('/api/members/search-filter/groups', [
            'name' => 'Wanaume Waliooa',
            'gender' => 'M',
            'marital_status' => 'Ameoa',
            'residential_zone' => 'MURUBOMBO',
            'education_level' => 'Degree',
        ])->assertCreated()->json('group.id');

        $pendingUser = User::factory()->create(['role' => null]);
        $pending = $this->createMember([
            'user_id' => $pendingUser->id,
            'gender' => 'M',
            'marital_status' => 'Ameoa',
            'residential_zone' => 'MURUBOMBO',
            'education_level' => 'Degree',
            'membership_status' => 'pending',
            'membership_number' => null,
            'is_authorized' => false,
            'phone_number' => null,
            'email' => null,
        ]);

        $this->postJson('/api/authorize-user', ['user_id' => $pendingUser->id])
            ->assertOk()
            ->assertJsonPath('auto_assigned_groups.0.id', $groupId);

        $this->assertDatabaseHas('member_group', [
            'group_id' => $groupId,
            'member_id' => $existing->id,
        ]);
        $this->assertDatabaseHas('member_group', [
            'group_id' => $groupId,
            'member_id' => $pending->id,
        ]);
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
            ->assertJsonPath('marriage.wife_id', $wife->id)
            ->assertJsonPath('marriage.married_at', '2026-05-01');

        $this->getJson('/api/member-marriages')
            ->assertOk()
            ->assertJsonPath('summary.total_marriages', 1)
            ->assertJsonCount(1, 'marriages');

        $this->deleteJson('/api/member-marriages/'.$response->json('marriage.id'))->assertOk();
        $this->assertNull($husband->fresh()->spouse_name);
        $this->assertNull($wife->fresh()->spouse_name);
    }

    public function test_member_marriage_can_resolve_frontend_user_ids(): void
    {
        User::factory()->count(5)->create(['role' => 'mshirika']);

        $husbandUser = User::factory()->create(['role' => 'mshirika']);
        $wifeUser = User::factory()->create(['role' => 'mshirika']);
        $husband = $this->createMember([
            'user_id' => $husbandUser->id,
            'gender' => 'M',
        ]);
        $wife = $this->createMember([
            'user_id' => $wifeUser->id,
            'gender' => 'F',
        ]);

        $this->postJson('/api/member-marriages', [
            'husband_id' => $husbandUser->id,
            'wife_id' => $wifeUser->id,
            'married_at' => '2026-06-08',
        ])
            ->assertCreated()
            ->assertJsonPath('marriage.husband_id', $husband->id)
            ->assertJsonPath('marriage.wife_id', $wife->id)
            ->assertJsonPath('marriage.married_at', '2026-06-08');

        $this->assertSame('Ameoa', $husband->fresh()->marital_status);
        $this->assertSame($husband->full_name, $wife->fresh()->spouse_name);
    }

    public function test_member_marriage_options_returns_husband_and_wife_selectors(): void
    {
        $husband = $this->createMember([
            'full_name' => 'Husband Member',
            'gender' => 'M',
            'membership_number' => '0001',
        ]);
        $wife = $this->createMember([
            'full_name' => 'Wife Member',
            'gender' => 'F',
            'membership_number' => '0002',
        ]);

        $this->getJson('/api/member-marriages/options')
            ->assertOk()
            ->assertJsonPath('husbands.0.member_id', $husband->id)
            ->assertJsonPath('husbands.0.user_id', $husband->user_id)
            ->assertJsonPath('wives.0.member_id', $wife->id)
            ->assertJsonPath('wives.0.user_id', $wife->user_id);
    }

    public function test_marriage_alias_route_and_spouse_name_fallback_work(): void
    {
        $member = $this->createMember([
            'gender' => 'M',
            'spouse_name' => 'Existing Spouse',
            'marital_status' => 'Ameoa',
        ]);

        $this->getJson('/api/marriages')
            ->assertOk()
            ->assertJsonPath('source', 'spouse_name')
            ->assertJsonPath('marriages.0.id', 'inferred-'.$member->id)
            ->assertJsonPath('marriages.0.spouse_name', 'Existing Spouse');
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
            ->assertJsonPath('statistics.total_members', 2)
            ->assertJsonPath('statistics.active_members', 2)
            ->assertJsonCount(2, 'members');

        $this->getJson("/api/groups/{$group->id}/members")
            ->assertOk()
            ->assertJsonPath('group.name', 'Youth')
            ->assertJsonPath('total_members', 2)
            ->assertJsonPath('statistics.total_members', 2)
            ->assertJsonCount(2, 'members');
    }

    public function test_member_update_accepts_255_phone_number_format(): void
    {
        $member = $this->createMember([
            'phone_number' => '0712345690',
            'email' => 'phone-update-original@example.com',
        ]);

        $this->putJson("/api/members/{$member->id}", [
            'full_name' => $member->full_name,
            'gender' => $member->gender,
            'phone_number' => '255712345699',
            'whatsapp_number' => '255712345698',
        ])
            ->assertOk()
            ->assertJsonPath('member.phone_number', '255712345699')
            ->assertJsonPath('member.whatsapp_number', '255712345698');

        $this->assertDatabaseHas('users', [
            'id' => $member->user_id,
            'phone' => '255712345699',
            'whatsapp_number' => '255712345698',
        ]);
    }

    public function test_announcements_and_events_support_new_crud_contract(): void
    {
        $choir = Group::create(['name' => 'Kwaya']);
        $youth = Group::create(['name' => 'Vijana']);

        $response = $this->postJson('/api/events', [
            'title' => 'Mkutano Mkuu',
            'type' => 'Tangazo',
            'description' => 'Washirika wote wahudhurie.',
            'start_date' => '2026-06-20',
            'end_date' => '2026-06-21',
            'start_time' => '09:30',
            'location' => 'Ukumbi Mkuu',
            'audience_group_ids' => [$choir->id, $youth->id],
        ]);

        $eventId = $response
            ->assertCreated()
            ->assertJsonPath('event.title', 'Mkutano Mkuu')
            ->assertJsonPath('event.type', 'Tangazo')
            ->assertJsonPath('event.date', '2026-06-20')
            ->assertJsonPath('event.start_date', '2026-06-20')
            ->assertJsonPath('event.end_date', '2026-06-21')
            ->assertJsonPath('event.start_time', '09:30')
            ->assertJsonPath('event.audience_groups.0.name', 'Kwaya')
            ->json('event.id');

        $this->getJson('/api/events?scope=all&type=Tangazo')
            ->assertOk()
            ->assertJsonPath('label', 'Matangazo & Matukio')
            ->assertJsonPath('events.0.id', $eventId)
            ->assertJsonPath('events.0.audience_groups.1.name', 'Vijana');

        $this->patchJson("/api/events/{$eventId}", [
            'title' => 'Mkutano wa Vijana',
            'type' => 'Tukio',
            'group_ids' => [$youth->id],
        ])
            ->assertOk()
            ->assertJsonPath('event.title', 'Mkutano wa Vijana')
            ->assertJsonPath('event.type', 'Tukio')
            ->assertJsonPath('event.audience_groups.0.name', 'Vijana');

        $this->deleteJson("/api/events/{$eventId}")
            ->assertOk();

        $this->assertDatabaseMissing('events', ['id' => $eventId]);
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

    public function test_sms_can_be_sent_to_mshiriki_by_membership_number(): void
    {
        Http::fake([
            '*' => Http::response('Sent', 200),
        ]);

        $member = $this->createMember([
            'full_name' => 'SMS Member',
            'membership_number' => '0021',
            'phone_number' => '0712345678',
            'email' => 'sms-member@example.com',
        ]);

        $this->postJson('/api/send-sms', [
            'type' => 'mshiriki',
            'receiver' => $member->membership_number,
            'message' => 'Test message',
        ])
            ->assertOk()
            ->assertJsonPath('status', 'success')
            ->assertJsonPath('summary.recipients', 1)
            ->assertJsonPath('summary.sms_sent', 1);

        $this->assertDatabaseHas('sms_logs', [
            'recipient' => '255712345678',
            'receiver' => '0021',
            'type' => 'mshiriki',
            'status' => 'Sent',
        ]);
    }

    public function test_sms_can_resolve_member_id_without_type(): void
    {
        Http::fake([
            '*' => Http::response('Sent', 200),
        ]);

        $member = $this->createMember([
            'phone_number' => '0712345679',
        ]);

        $this->postJson('/api/send-sms', [
            'member_id' => $member->id,
            'message' => 'Test message',
        ])
            ->assertOk()
            ->assertJsonPath('status', 'success')
            ->assertJsonPath('summary.recipients', 1)
            ->assertJsonPath('summary.sms_sent', 1);

        $this->assertDatabaseHas('sms_logs', [
            'recipient' => '255712345679',
            'receiver' => (string) $member->id,
            'type' => 'direct',
            'status' => 'Sent',
        ]);
    }

    public function test_sms_sends_once_when_duplicate_members_share_phone(): void
    {
        Http::fake([
            '*' => Http::response('Sent', 200),
        ]);

        $this->createMember([
            'membership_status' => 'active',
            'phone_number' => '0712345680',
        ]);
        $this->createMember([
            'membership_status' => 'active',
            'phone_number' => '255712345680',
        ]);

        $this->postJson('/api/send-sms', [
            'type' => 'washiriki',
            'message' => 'Duplicate guard test',
        ])
            ->assertOk()
            ->assertJsonPath('summary.sms_sent', 1)
            ->assertJsonPath('summary.duplicates_skipped', 1);

        Http::assertSentCount(1);
    }

    public function test_sms_recent_duplicate_request_is_not_sent_again(): void
    {
        Http::fake([
            '*' => Http::response('Sent', 200),
        ]);

        $member = $this->createMember([
            'phone_number' => '0712345681',
        ]);

        $payload = [
            'member_id' => $member->id,
            'message' => 'Do not send twice',
        ];

        $this->postJson('/api/send-sms', $payload)
            ->assertOk()
            ->assertJsonPath('summary.sms_sent', 1)
            ->assertJsonPath('summary.duplicates_skipped', 0);

        $this->postJson('/api/send-sms', $payload)
            ->assertOk()
            ->assertJsonPath('summary.sms_sent', 0)
            ->assertJsonPath('summary.duplicates_skipped', 1);

        Http::assertSentCount(1);
    }

    public function test_sms_user_id_prefers_linked_member_phone(): void
    {
        Http::fake([
            '*' => Http::response('Sent', 200),
        ]);

        $user = User::factory()->create([
            'role' => 'mshirika',
            'phone' => '255799999999',
        ]);
        $this->createMember([
            'user_id' => $user->id,
            'phone_number' => '0712345682',
        ]);

        $this->postJson('/api/send-sms', [
            'user_id' => $user->id,
            'message' => 'Use member phone',
        ])
            ->assertOk()
            ->assertJsonPath('summary.sms_sent', 1);

        $this->assertDatabaseHas('sms_logs', [
            'recipient' => '255712345682',
            'receiver' => (string) $user->id,
            'status' => 'Sent',
        ]);
        $this->assertDatabaseMissing('sms_logs', [
            'recipient' => '255799999999',
            'message' => 'Use member phone',
        ]);
        Http::assertSentCount(1);
    }

    public function test_sms_member_id_ignores_extra_direct_phone(): void
    {
        Http::fake([
            '*' => Http::response('Sent', 200),
        ]);

        $member = $this->createMember([
            'phone_number' => '0712345683',
        ]);

        $this->postJson('/api/send-sms', [
            'member_id' => $member->id,
            'phone' => '0799999999',
            'message' => 'Selected member only',
        ])
            ->assertOk()
            ->assertJsonPath('summary.sms_sent', 1);

        $this->assertDatabaseHas('sms_logs', [
            'recipient' => '255712345683',
            'receiver' => (string) $member->id,
            'status' => 'Sent',
        ]);
        $this->assertDatabaseMissing('sms_logs', [
            'recipient' => '255799999999',
            'message' => 'Selected member only',
        ]);
        Http::assertSentCount(1);
    }

    public function test_sms_washiriki_type_with_member_id_sends_only_selected_member(): void
    {
        Http::fake([
            '*' => Http::response('Sent', 200),
        ]);

        $selected = $this->createMember([
            'phone_number' => '0712345684',
        ]);
        $this->createMember([
            'phone_number' => '0712345685',
        ]);
        $this->createMember([
            'phone_number' => '0712345686',
        ]);

        $this->postJson('/api/send-sms', [
            'type' => 'washiriki',
            'member_id' => $selected->id,
            'message' => 'Only selected member',
        ])
            ->assertOk()
            ->assertJsonPath('summary.recipients', 1)
            ->assertJsonPath('summary.sms_sent', 1);

        $this->assertDatabaseHas('sms_logs', [
            'recipient' => '255712345684',
            'receiver' => (string) $selected->id,
            'status' => 'Sent',
        ]);
        $this->assertDatabaseMissing('sms_logs', [
            'recipient' => '255712345685',
            'message' => 'Only selected member',
        ]);
        $this->assertDatabaseMissing('sms_logs', [
            'recipient' => '255712345686',
            'message' => 'Only selected member',
        ]);
        Http::assertSentCount(1);
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
