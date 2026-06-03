<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Mail\MemberAuthorizedMail;
use App\Models\DeletedMember;
use App\Models\LeadershipRole;
use App\Models\Member;
use App\Models\User;
use App\Services\SMSService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;
use Illuminate\Support\Str;






class MembersController extends Controller
{
    /**
     * List all members
     */
    public function index()
    {
        return response()->json([
            'status' => 'success',
            'members' => Member::with('user')->get()
        ]);
    }

    /**
     * Show a specific member
     */
    public function show(int $id)
    {
        $member = Member::with('user')->find($id);

        if (!$member) {
            return response()->json(['status' => 'error', 'message' => 'Member not found'], 404);
        }

        return response()->json(['status' => 'success', 'member' => $member]);
    }

    /**
     * Create a new member and user
     */
    public function store(Request $request)
    {
        $request->merge([
            'gender' => match ($request->gender) {
                'Mwanaume' => 'M',
                'Mwanamke' => 'F',
                default => $request->gender,
            },
        ]);

        if ($request->marital_status !== 'Ndoa') {
            $request->merge(['spouse_name' => null]);
        }

        $zoneValues = ['MURUBOMBO','MURUSI B','KIGANAMO','MURUSI A','KUMUNYIKA B','KAGUNGA C','KUMUNYIKA A','KAGANGA B','MURUBONA A','KAGUNGA A'];

        $validator = Validator::make($request->all(), [
            'full_name' => 'required|string|max:255',
            'gender' => 'required|in:M,F',
            'birth_date' => 'nullable|date',
            'birth_place' => 'nullable|string|max:255',
            'birth_region' => 'nullable|string|max:255',
            'birth_ward' => 'nullable|string|max:255',
            'birth_street' => 'nullable|string|max:255',
            'marital_status' => 'nullable|in:Ndoa,Bila ndoa',
            'marriage_type' => 'nullable|in:Kikristo,Kiserikali,Kienyeji',
            'spouse_name' => 'nullable|string|max:255|required_if:marital_status,Ndoa',
            'number_of_children' => 'nullable|integer|min:0',
            'residential_zone' => ['nullable', Rule::in($zoneValues)],
            'residential_ward' => 'nullable|string|max:255',
            'residential_street' => 'nullable|string|max:255',
            'phone_number' => 'nullable|string|max:20|unique:users,phone',
            'email' => 'nullable|email|max:255|unique:users,email',
            'has_disability' => 'nullable|boolean',
            'disability_description' => 'nullable|string|max:500|required_if:has_disability,true,1',
            'occupation' => 'required|string',
            'work_place' => 'nullable|string',
        ]);

        if ($validator->fails()) {
            return response()->json(['status' => 'error', 'errors' => $validator->errors()], 422);
        }

        try {
            DB::beginTransaction();

            $user = User::create([
                'full_name' => $request->full_name,
                'gender' => $request->gender,
                'birth_date' => $request->birth_date,
                'birth_place' => $request->birth_place,
                'birth_region' => $request->birth_region,
                'birth_ward' => $request->birth_ward,
                'birth_street' => $request->birth_street,
                'marital_status' => $request->marital_status,
                'marriage_type' => $request->marriage_type,
                'spouse_name' => $request->spouse_name,
                'children_count' => $request->number_of_children,
                'zone' => $request->residential_zone,
                'residential_ward' => $request->residential_ward,
                'residential_street' => $request->residential_street,
                'phone' => $request->phone_number,
                'whatsapp_number' => $request->whatsapp_number,
                'email' => $request->email,
                'has_disability' => $request->has_disability ?? false,
                'disability_description' => $request->disability_description,
                'password' => Hash::make('defaultpassword'),
                'role' => 'mshirika',
            ]);

            $membershipNumber = $this->generateMembershipNumber();

            $member = Member::create([
                'user_id' => $user->id,
                'full_name' => $request->full_name,
                'gender' => $request->gender,
                'birth_date' => $request->birth_date,
                'birth_place' => $request->birth_place,
                'birth_region' => $request->birth_region,
                'birth_ward' => $request->birth_ward,
                'birth_street' => $request->birth_street,
                'marital_status' => $request->marital_status,
                'marriage_type' => $request->marriage_type,
                'spouse_name' => $request->spouse_name,
                'number_of_children' => $request->number_of_children,
                'residential_zone' => $request->residential_zone,
                'residential_ward' => $request->residential_ward,
                'residential_street' => $request->residential_street,
                'phone_number' => $request->phone_number,
                'email' => $request->email,
                'has_disability' => $request->has_disability ?? false,
                'disability_description' => $request->disability_description,
                'occupation' => $request->occupation,
                'work_place' => $request->work_place,
                'membership_status' => 'pending',
                'membership_number' => $membershipNumber,
            ]);

            DB::commit();

            $this->notifyMember($member);

            return response()->json([
                'status' => 'success',
                'message' => 'Member and user created successfully',
                'member' => $member,
                'user' => $user,
            ], 201);

        } catch (\Throwable $e) {
            DB::rollBack();
            return response()->json([
                'status' => 'error',
                'message' => 'Server Error: ' . $e->getMessage(),
            ], 500);
        }
    }


    public function byUser(int $userId)
{
    $member = Member::where('user_id', $userId)->first();
    if (!$member) {
        return response()->json(['message' => 'Member not found'], 404);
    }
    return response()->json(['member' => $member]);
}




public function update(Request $request, Member $member)
{
    $user = $member->user;

        $user = $member->user;

    // Block editing if membership number not set
    if (empty($member->membership_number)) {
        return response()->json([
            'status' => 'error',
            'message' => 'Huyu mshirika bado hajaidhinishwa, hivyo huwezi kumhariri.',
        ], 422);
    }

    /*
    |--------------------------------------------------------------------------
    | Normalize values
    |--------------------------------------------------------------------------
    */

    $gender = match ($request->gender) {
        'Mwanaume' => 'M',
        'Mwanamke' => 'F',
        default => $request->gender,
    };

    $maritalStatus = match ($request->marital_status) {
        'Ndoa' => $gender === 'F' ? 'Ameolewa' : 'Ameoa',
        'Bila ndoa' => $gender === 'F' ? 'Hajaolewa' : 'Hajaoa',
        default => $request->marital_status,
    };

    $livesAlone = filter_var($request->lives_alone, FILTER_VALIDATE_BOOLEAN, FILTER_NULL_ON_FAILURE);
    $isAuthorized = filter_var($request->is_authorized, FILTER_VALIDATE_BOOLEAN, FILTER_NULL_ON_FAILURE);

    if (!in_array($maritalStatus, ['Ameoa', 'Ameolewa'])) {
        $request->merge(['spouse_name' => null]);
    }

    /*
    |--------------------------------------------------------------------------
    | Format phone
    |--------------------------------------------------------------------------
    */

    $formattedPhone = preg_replace('/\D/', '', $request->phone_number ?? '');
    if ($formattedPhone && str_starts_with($formattedPhone, '0')) {
        $formattedPhone = '255' . substr($formattedPhone, 1);
    }

    try {
        DB::beginTransaction();

        /*
        |--------------------------------------------------------------------------
        | Update or create user
        |--------------------------------------------------------------------------
        */

        if ($user) {
            $user->update([
                'full_name' => $request->full_name ?? $user->full_name,
                'gender' => $gender ?? $user->gender,
                'birth_date' => $request->birth_date ?? $user->birth_date,
                'birth_place' => $request->birth_place ?? $user->birth_place,
                'birth_region' => $request->birth_region ?? $user->birth_region,
                'birth_ward' => $request->birth_ward ?? $user->birth_ward,
                'birth_street' => $request->birth_street ?? $user->birth_street,
                'marital_status' => $maritalStatus ?? $user->marital_status,
                'marriage_type' => $request->marriage_type ?? $user->marriage_type,
                'spouse_name' => $request->spouse_name ?? $user->spouse_name,
                'children_count' => $request->number_of_children ?? $user->children_count,
                'zone' => $request->residential_zone ?? $user->zone,
                'residential_ward' => $request->residential_ward ?? $user->residential_ward,
                'residential_street' => $request->residential_street ?? $user->residential_street,
                'phone' => $formattedPhone ?: $user->phone,
                'email' => $request->email ?? $user->email,
                'has_disability' => $request->has_disability ?? $user->has_disability,
                'disability_description' => $request->disability_description ?? $user->disability_description,
            ]);
        } else {
            $user = User::create([
                'full_name' => $request->full_name,
                'gender' => $gender,
                'birth_date' => $request->birth_date,
                'birth_place' => $request->birth_place,
                'birth_region' => $request->birth_region,
                'birth_ward' => $request->birth_ward,
                'birth_street' => $request->birth_street,
                'marital_status' => $maritalStatus,
                'marriage_type' => $request->marriage_type,
                'spouse_name' => $request->spouse_name,
                'children_count' => $request->number_of_children,
                'zone' => $request->residential_zone,
                'residential_ward' => $request->residential_ward,
                'residential_street' => $request->residential_street,
                'phone' => $formattedPhone,
                'email' => $request->email,
                'has_disability' => $request->has_disability ?? false,
                'disability_description' => $request->disability_description,
                'password' => Hash::make(Str::random(10)),
            ]);
        }

        /*
        |--------------------------------------------------------------------------
        | Update member (NO validation block)
        |--------------------------------------------------------------------------
        */

        $member->update([
            'user_id' => $user->id,
            'full_name' => $request->full_name ?? $member->full_name,
            'gender' => $gender ?? $member->gender,
            'birth_date' => $request->birth_date ?? $member->birth_date,
            'birth_place' => $request->birth_place ?? $member->birth_place,
            'birth_region' => $request->birth_region ?? $member->birth_region,
            'birth_ward' => $request->birth_ward ?? $member->birth_ward,
            'birth_street' => $request->birth_street ?? $member->birth_street,
            'marital_status' => $maritalStatus ?? $member->marital_status,
            'marriage_type' => $request->marriage_type ?? $member->marriage_type,
            'spouse_name' => $request->spouse_name ?? $member->spouse_name,
            'number_of_children' => $request->number_of_children ?? $member->number_of_children,
            'residential_zone' => $request->residential_zone ?? $member->residential_zone,
            'residential_ward' => $request->residential_ward ?? $member->residential_ward,
            'residential_street' => $request->residential_street ?? $member->residential_street,
            'phone_number' => $formattedPhone ?: $member->phone_number,
            'email' => $request->email ?? $member->email,
            'has_disability' => $request->has_disability ?? $member->has_disability,
            'disability_description' => $request->disability_description ?? $member->disability_description,

            // Imani
            'date_of_conversion' => $request->date_of_conversion ?? $member->date_of_conversion,
            'conversion_year' => $request->conversion_year ?? $member->conversion_year,
            'conversion_month' => $request->conversion_month ?? $member->conversion_month,
            'conversion_day' => $request->conversion_day ?? $member->conversion_day,
            'church_of_conversion' => $request->church_of_conversion ?? $member->church_of_conversion,
            'baptism_date' => $request->baptism_date ?? $member->baptism_date,
            'baptism_year' => $request->baptism_year ?? $member->baptism_year,
            'baptism_month' => $request->baptism_month ?? $member->baptism_month,
            'baptism_day' => $request->baptism_day ?? $member->baptism_day,
            'baptism_place' => $request->baptism_place ?? $member->baptism_place,
            'baptizer_name' => $request->baptizer_name ?? $member->baptizer_name,
            'baptizer_title' => $request->baptizer_title ?? $member->baptizer_title,
            'previous_church' => $request->previous_church ?? $member->previous_church,
            'church_service' => $request->church_service ?? $member->church_service,
            'service_duration' => $request->service_duration ?? $member->service_duration,
            'participates_communion' => $request->participates_communion ?? $member->participates_communion,

            // Education
            'education_level' => $request->education_level ?? $member->education_level,
            'profession' => $request->profession ?? $member->profession,
            'occupation' => $request->occupation ?? $member->occupation,
            'work_place' => $request->work_place ?? $member->work_place,
            'work_contact' => $request->work_contact ?? $member->work_contact,

            // Family
            'lives_alone' => $livesAlone ?? $member->lives_alone,
            'lives_with' => $request->lives_with ?? $member->lives_with,
            'family_role' => $request->family_role ?? $member->family_role,
            'live_with_who' => $request->live_with_who ?? $member->live_with_who,
            'next_of_kin' => $request->next_of_kin ?? $member->next_of_kin,
            'next_of_kin_phone' => $request->next_of_kin_phone ?? $member->next_of_kin_phone,

            // Membership
            'membership_number' => $request->membership_number ?? $member->membership_number,
            'verified_by' => $request->verified_by ?? $member->verified_by,
            'membership_start_date' => $request->membership_start_date ?? $member->membership_start_date,
            'membership_status' => $request->membership_status ?? $member->membership_status,
            'deactivation_reason' => $request->deactivation_reason ?? $member->deactivation_reason,
            'is_authorized' => $isAuthorized ?? $member->is_authorized,
        ]);

        DB::commit();

        return response()->json([
            'status' => 'success',
            'message' => 'Mabadiliko yamehifadhiwa!',
            'member' => $member->fresh()->load('user'),
        ]);

    } catch (\Throwable $e) {
        DB::rollBack();

        return response()->json([
            'status' => 'error',
            'message' => $e->getMessage(),
        ], 500);
    }
}
    /**
     * Authorize an existing user as a member
     */
public function authorizeUser(Request $request)
{
    $request->validate([
        'user_id' => 'required|exists:users,id',
    ]);

    $user = User::find($request->user_id);

    if ($user->member) {

        $user->role = 'mshirika';
        $user->save();

        $member = $user->member;

        //  Update status to active
        $member->update([
            'membership_status' => 'active',
            'membership_number' => $member->membership_number ?? $this->generateMembershipNumber(),
            'is_authorized' => 1,
        ]);

    } else {

        $membershipNumber = $this->generateMembershipNumber();

        $member = Member::create([
            'user_id' => $user->id,
            'full_name' => $user->full_name,
            'gender' => $user->gender,
            'birth_date' => $user->birth_date,
            'birth_place' => $user->birth_place,
            'marital_status' => $user->marital_status,
            'spouse_name' => $user->spouse_name,
            'number_of_children' => $user->children_count,
            'residential_zone' => $user->zone,
            'phone_number' => $user->phone,
            'email' => $user->email,
            'membership_status' => 'active',
            'membership_number' => $membershipNumber,
            'is_authorized' => 1,
        ]);

        $user->role = 'mshirika';
        $user->save();
    }

    $this->notifyMember($member);

    return response()->json([
        'status' => 'success',
        'message' => 'User authorized as member successfully, notifications sent.',
        'member' => $member,
        'user' => $user,
    ]);
}

    /**
     * Activate member
     */
   public function activate(Member $member)
{
    if ($member->membership_status === 'pending') {
        return response()->json([
            'status' => 'info',
            'message' => 'Member already pending approval.',
        ]);
    }

    $member->update([
        'membership_status' => 'pending', // set to pending instead of active
        'deactivation_reason' => null,
        // Do NOT assign membership number here
    ]);

    $this->notifyMember($member);

    return response()->json([
        'status' => 'success',
        'message' => 'Member status set to pending. Notifications sent.',
    ]);
}
    /**
     * Deactivate member
     */
   public function deactivate(Request $request, Member $member)
{
    $reasons = [
        'Amehama' => 'left',
        'Ametegwa ushirika' => 'detained',
        'Amefariki' => 'deceased',
        'Amepotea' => 'lost',
        'Amejisajiri kimakosa' => 'lost',
    ];

    $request->validate([
        'reason' => ['required', Rule::in(array_keys($reasons))],
    ]);

    $status = $reasons[$request->reason];

    $member->update([
        'membership_status' => $status,
        'deactivation_reason' => $request->reason,
    ]);

    return response()->json([
        'status' => 'success',
        'message' => 'Member deactivated successfully.',
        'member' => $member,
    ]);
}

public function stats()
{
    return response()->json([
        'status' => 'success',
        'total_members' => Member::where('membership_status', 'active')->count(),
    ]);
}



    /**
     * List deleted members
     */
    public function deleted()
    {
        return response()->json([
            'status' => 'success',
            'deleted_members' => DeletedMember::latest()->get(),
        ]);
    }

    /**
     * Restore a deleted member
     */
    public function restore(int $id)
    {
        $record = DeletedMember::find($id);

        if (!$record) {
            return response()->json(['status' => 'error', 'message' => 'Deleted member not found'], 404);
        }

        $restored = Member::create([
            'user_id' => $record->user_id,
            'full_name' => $record->full_name,
            'gender' => $record->gender,
            'birth_date' => $record->birth_date,
            'phone_number' => $record->phone,
            'email' => $record->email,
            'membership_status' => 'active',
        ]);

        DeletedMember::destroy($id);

        return response()->json([
            'status' => 'success',
            'message' => 'Member restored successfully.',
            'member' => $restored,
        ]);
    }

    /**
     * Delete member and user
     */
    public function deleteBoth(int $id)
    {
        $member = Member::find($id);

        if (!$member) {
            return response()->json(['status' => 'error', 'message' => 'Member not found'], 404);
        }

        try {
            $user = $member->user;

            DeletedMember::create([
                'user_id' => $user->id,
                'full_name' => $member->full_name,
                'email' => $member->email,
                'phone' => $member->phone_number,
                'gender' => $member->gender,
                'birth_date' => $member->birth_date,
                'reason' => 'deleted manually',
                'deleted_by' => auth()->user()->full_name ?? 'system',
                'deleted_at' => now(),
            ]);

            $member->delete();
            $user->delete();

            return response()->json([
                'status' => 'success',
                'message' => 'Member and user deleted successfully',
            ]);
        } catch (\Throwable $e) {
            return response()->json([
                'status' => 'error',
                'message' => 'Error deleting user and member: ' . $e->getMessage(),
            ], 500);
        }
    }

    /**
     * Assign leadership role
     */
    public function assignLeadershipRole(Request $request)
{
    $request->validate([
        'user_id' => 'required|exists:users,id',
        'role_title' => 'required|string|exists:leadership_roles,title',
    ]);

    $user = User::findOrFail($request->user_id);
    $role = LeadershipRole::where('title', $request->role_title)->firstOrFail();

    /*
    |--------------------------------------------------------------------------
    | Map leadership title to system login role
    |--------------------------------------------------------------------------
    */
    $systemRole = match (strtolower(trim($role->title))) {
        'mchungaji',
        'mchungaji kiongozi' => 'mchungaji',

        'katibu',
        'katibu msaidizi' => 'katibu',

        'mhasibu',
        'mweka hazina' => 'mhasibu',

        default => 'kiongozi',
    };

    $user->update([
        'role_id' => $role->id,
        'role' => $systemRole,
    ]);

    return response()->json([
        'status' => 'success',
        'message' => 'User leadership role assigned successfully.',
        'assigned_title' => $role->title,
        'system_role' => $systemRole,
        'user' => $user,
    ]);
}
    /**
     * Generate unique membership number
     */
    private function generateMembershipNumber()
    {
        $lastNumber = Member::max(DB::raw('CAST(membership_number AS UNSIGNED)'));
        $newNumber = $lastNumber ? $lastNumber + 1 : 1;

        return str_pad($newNumber, 4, '0', STR_PAD_LEFT);
    }

    /**
     * Notify member via SMS and Email
     */
 private function notifyMember(Member $member)
{
    // Refresh member
    $member = $member->fresh();

    // Only generate membership number if member is active/approved
    if ($member->membership_status === 'active' && !$member->membership_number) {
        $member->membership_number = $this->generateMembershipNumber();
        $member->save();
    }

    $membershipNumber = $member->membership_number ?? '—';
    $fullName = $member->full_name;

    // Send SMS
    if ($member->phone_number) {
        try {
            $text = "Habari {$fullName}, usajili wako  FPCT KASULU MJINI  umekamilika. "
                  . "Namba yako ya ushirika ni: {$membershipNumber}. Karibu  FPCT KASULU MJINI .";

            app(SMSService::class)->sendSMS($member->phone_number, $text);
        } catch (\Throwable $e) {
            Log::error("SMS sending failed: " . $e->getMessage());
        }
    }

    // Send Email
    if ($member->email) {
        try {
            Mail::to($member->email)->send(
                new MemberAuthorizedMail($fullName, $membershipNumber)
            );
        } catch (\Throwable $e) {
            Log::error("Email sending failed: " . $e->getMessage());
        }
    }
}
}
