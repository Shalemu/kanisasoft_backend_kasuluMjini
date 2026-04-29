<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use App\Models\User;
use App\Models\Member;
use Illuminate\Support\Facades\Password;
use Illuminate\Support\Str;
use App\Notifications\NewUserRegistered;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\Rule; // also needed for Rule::in()





class AuthController extends Controller
{
    /**
     * Convert any format to Tanzania standard: 255XXXXXXXXX
     */
    private function formatTanzaniaPhone(string $phone)
    {
        // Remove non-numeric characters
        $num = preg_replace('/\D/', '', $phone);

        // If starts with 0 -> remove it
        if (str_starts_with($num, '0')) {
            $num = substr($num, 1);
        }

        // If already 255XXXXXXXXX -> return as is
        if (str_starts_with($num, '255')) {
            return $num;
        }

        // If 9 digits (like 767983236)
        if (strlen($num) === 9) {
            return '255' . $num;
        }

        // Last fallback
        return $num;
    }

    /**
     * REGISTER USER
     */
    public function register(Request $request)
    {
        // Convert gender & phone before validation
        $request->merge([
            'gender' => match ($request->gender) {
                'Mwanaume' => 'M',
                'Mwanamke' => 'F',
                default => $request->gender,
            },
            'phone' => $this->formatTanzaniaPhone($request->phone),
        ]);

        $zoneValues = ['MURUBOMBO','MURUSI B','KIGANAMO','MURUSI A','KUMUNYIKA B','KAGUNGA C','KUMUNYIKA A','KAGANGA B','MURUBONA A','KAGUNGA A'];

        $request->validate([
            'full_name' => 'required|string|max:255',
            'gender' => 'required|in:M,F',
            'birth_date' => 'nullable|date',
            'birth_place' => 'nullable|string|max:255',
            'birth_region' => 'nullable|string|max:255',
            'birth_ward' => 'nullable|string|max:255',
            'birth_street' => 'nullable|string|max:255',
            'marital_status' => 'nullable|in:Ameoa,Ameolewa,Hajaoa,Hajaolewa,Mjane,Mgane',
            'marriage_type' => 'nullable|in:Kikristo,Kiserikali,Kienyeji',
            'spouse_name' => 'nullable|string|max:255|required_if:marital_status,Ameoa,Ameolewa',
            'children_count' => 'nullable|integer|min:0',
            'zone' => ['nullable', Rule::in($zoneValues)],
            'residential_ward' => 'nullable|string|max:255',
            'residential_street' => 'nullable|string|max:255',
            'phone' => [
                'required',
                'regex:/^255[0-9]{9}$/',
                'unique:users,phone'
            ],
            'whatsapp_number' => [
                'nullable',
                'regex:/^(0[0-9]{9}|255[0-9]{9})$/'
            ],
            'email' => 'required|email|max:255|unique:users,email',
            'password' => 'required|string|min:6|confirmed',

            // Disability
            'has_disability' => 'nullable|boolean',
            'disability_description' => 'nullable|string|max:500|required_if:has_disability,true,1',

            // Imani
            'date_of_conversion' => 'nullable|date',
            'conversion_year' => 'nullable|integer|min:1900|max:2100',
            'conversion_month' => 'nullable|integer|min:1|max:12',
            'conversion_day' => 'nullable|integer|min:1|max:31',
            'church_of_conversion' => 'nullable|string',
            'baptism_date' => 'nullable|date',
            'baptism_year' => 'nullable|integer|min:1900|max:2100',
            'baptism_month' => 'nullable|integer|min:1|max:12',
            'baptism_day' => 'nullable|integer|min:1|max:31',
            'baptism_place' => 'nullable|string',
            'baptizer_name' => 'nullable|string',
            'baptizer_title' => 'nullable|string',
            'previous_church' => 'nullable|string',
            'church_service' => 'nullable|string',
            'service_duration' => 'nullable|string',
            'participates_communion' => 'nullable|boolean',

            // Elimu
            'education_level' => 'nullable|string',
            'profession' => 'nullable|string',
            'occupation' => 'required|string',
            'work_place' => 'nullable|string',
            'work_contact' => 'nullable|string',

            // Familia
            'lives_alone' => 'nullable|boolean',
            'lives_with' => 'nullable|string',
        ]);

        try {
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
                'children_count' => $request->children_count,
                'zone' => $request->zone,
                'residential_ward' => $request->residential_ward,
                'residential_street' => $request->residential_street,
                'phone' => $request->phone,
                'whatsapp_number' => $request->whatsapp_number,
                'email' => $request->email,
                'has_disability' => $request->has_disability ?? false,
                'disability_description' => $request->disability_description,
                'password' => Hash::make($request->password),
                'role' => null,
            ]);

            Member::create([
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
                'number_of_children' => $request->children_count,
                'residential_zone' => $request->zone,
                'residential_ward' => $request->residential_ward,
                'residential_street' => $request->residential_street,
                'phone_number' => $request->phone,
                'email' => $request->email,
                'has_disability' => $request->has_disability ?? false,
                'disability_description' => $request->disability_description,

                'date_of_conversion' => $request->date_of_conversion,
                'conversion_year' => $request->conversion_year,
                'conversion_month' => $request->conversion_month,
                'conversion_day' => $request->conversion_day,
                'church_of_conversion' => $request->church_of_conversion,
                'baptism_date' => $request->baptism_date,
                'baptism_year' => $request->baptism_year,
                'baptism_month' => $request->baptism_month,
                'baptism_day' => $request->baptism_day,
                'baptism_place' => $request->baptism_place,
                'baptizer_name' => $request->baptizer_name,
                'baptizer_title' => $request->baptizer_title,
                'previous_church' => $request->previous_church,
                'church_service' => $request->church_service,
                'service_duration' => $request->service_duration,
                'participates_communion' => $request->participates_communion,

                'education_level' => $request->education_level,
                'profession' => $request->profession,
                'occupation' => $request->occupation,
                'work_place' => $request->work_place,
                'work_contact' => $request->work_contact,

                'lives_alone' => $request->lives_alone,
                'lives_with' => $request->lives_with,

                'membership_status' => 'pending',
            ]);

                    // Notify admins
        $notificationStatus = [];
        $admins = User::where('role', 'admin')->get();
        foreach ($admins as $admin) {
            try {
                $admin->notify(new NewUserRegistered($user));
                $notificationStatus[$admin->email] = 'sent';
            } catch (\Throwable $ex) {
                $notificationStatus[$admin->email] = 'failed: ' . $ex->getMessage();
            }
        }

            $token = $user->createToken('auth_token')->plainTextToken;

            return response()->json([
                'status' => 'success',
                'message' => 'User registered and member profile created successfully.',
                'token' => $token,
                'user' => $user,
            ]);
        } catch (\Throwable $e) {
            return response()->json([
                'status' => 'error',
                'message' => 'Server error: ' . $e->getMessage(),
            ], 500);
        }
    }


    



    /**
     * UPDATE PROFILE
     */
public function updateProfile(Request $request)
{
    $user = $request->user();

    // Normalize fields before validation
    $request->merge([
        'marital_status' => isset($request->marital_status) ? trim($request->marital_status) : null,
        'gender' => match ($request->gender ?? '') {
            'Mwanaume' => 'M',
            'Mwanamke' => 'F',
            default => $request->gender,
        },
        'phone' => $this->formatTanzaniaPhone($request->phone ?? ''),
    ]);

    // Validation rules
    $zoneValues = ['MURUBOMBO','MURUSI B','KIGANAMO','MURUSI A','KUMUNYIKA B','KAGUNGA C','KUMUNYIKA A','KAGANGA B','MURUBONA A','KAGUNGA A'];

    $request->validate([
        'full_name' => 'required|string|max:255',
        'gender' => 'required|in:M,F',
        'birth_date' => 'nullable|date',
        'birth_place' => 'nullable|string|max:255',
        'birth_region' => 'nullable|string|max:255',
        'birth_ward' => 'nullable|string|max:255',
        'birth_street' => 'nullable|string|max:255',
        'marital_status' => ['nullable', Rule::in(['Ameoa','Ameolewa','Hajaoa','Hajaolewa','Mjane','Mgane'])],
        'marriage_type' => 'nullable|in:Kikristo,Kiserikali,Kienyeji',
        'spouse_name' => 'sometimes|required_if:marital_status,Ameoa,Ameolewa|string|max:255',
        'children_count' => 'nullable|integer|min:0',
        'zone' => ['nullable', Rule::in($zoneValues)],
        'residential_ward' => 'nullable|string|max:255',
        'residential_street' => 'nullable|string|max:255',
        'phone' => ['required','string','max:20','unique:users,phone,' . $user->id],
        'email' => ['required','email','max:255','unique:users,email,' . $user->id],

        // Disability
        'has_disability' => 'nullable|boolean',
        'disability_description' => 'nullable|string|max:500|required_if:has_disability,true,1',

        // Imani
        'date_of_conversion' => 'nullable|date',
        'conversion_year' => 'nullable|integer|min:1900|max:2100',
        'conversion_month' => 'nullable|integer|min:1|max:12',
        'conversion_day' => 'nullable|integer|min:1|max:31',
        'church_of_conversion' => 'nullable|string',
        'baptism_date' => 'nullable|date',
        'baptism_year' => 'nullable|integer|min:1900|max:2100',
        'baptism_month' => 'nullable|integer|min:1|max:12',
        'baptism_day' => 'nullable|integer|min:1|max:31',
        'baptism_place' => 'nullable|string',
        'baptizer_name' => 'nullable|string',
        'baptizer_title' => 'nullable|string',
        'previous_church' => 'nullable|string',
        'church_service' => 'nullable|string',
        'service_duration' => 'nullable|string',
        'participates_communion' => 'nullable|boolean',

        // Elimu
        'education_level' => 'nullable|string',
        'profession' => 'nullable|string',
        'occupation' => 'required|string',
        'work_place' => 'nullable|string',
        'work_contact' => 'nullable|string',

        // Familia
        'lives_alone' => 'nullable|boolean',
        'lives_with' => 'nullable|string',
    ]);

    // Start transaction
    DB::beginTransaction();
    try {
        // Update User
        $user->update([
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
            'children_count' => $request->children_count,
            'zone' => $request->zone,
            'residential_ward' => $request->residential_ward,
            'residential_street' => $request->residential_street,
            'phone' => $request->phone,
            'email' => $request->email,
            'has_disability' => $request->has_disability ?? false,
            'disability_description' => $request->disability_description,
        ]);

        // Update or create Member
        $member = Member::updateOrCreate(
            ['user_id' => $user->id],
            [
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
                'number_of_children' => $request->children_count,
                'residential_zone' => $request->zone,
                'residential_ward' => $request->residential_ward,
                'residential_street' => $request->residential_street,
                'phone_number' => $request->phone,
                'email' => $request->email,
                'has_disability' => $request->has_disability ?? false,
                'disability_description' => $request->disability_description,

                'date_of_conversion' => $request->date_of_conversion,
                'conversion_year' => $request->conversion_year,
                'conversion_month' => $request->conversion_month,
                'conversion_day' => $request->conversion_day,
                'church_of_conversion' => $request->church_of_conversion,
                'baptism_date' => $request->baptism_date,
                'baptism_year' => $request->baptism_year,
                'baptism_month' => $request->baptism_month,
                'baptism_day' => $request->baptism_day,
                'baptism_place' => $request->baptism_place,
                'baptizer_name' => $request->baptizer_name,
                'baptizer_title' => $request->baptizer_title,
                'previous_church' => $request->previous_church,
                'church_service' => $request->church_service,
                'service_duration' => $request->service_duration,
                'participates_communion' => $request->participates_communion,

                'education_level' => $request->education_level,
                'profession' => $request->profession,
                'occupation' => $request->occupation,
                'work_place' => $request->work_place,
                'work_contact' => $request->work_contact,

                'lives_alone' => $request->lives_alone,
                'lives_with' => $request->lives_with,
            ]
        );

        DB::commit();

        return response()->json([
            'status' => 'success',
            'message' => 'Profile updated successfully.',
            'member' => $member->fresh()->load('user'),
        ]);
    } catch (\Throwable $e) {
        DB::rollBack();
        return response()->json([
            'status' => 'error',
            'message' => 'Server error: ' . $e->getMessage(),
        ], 500);
    }
}


    /**
     * LOGIN
     */
    public function login(Request $request)
    {
        $request->validate([
            'login' => 'required|string',
            'password' => 'required|string',
        ]);

        $loginField = filter_var($request->login, FILTER_VALIDATE_EMAIL) ? 'email' : 'phone';

        if (!Auth::attempt([$loginField => $request->login, 'password' => $request->password])) {
            return response()->json([
                'status' => 'error',
                'message' => 'Invalid credentials',
            ], 401);
        }

        /** @var \App\Models\User $user */
        $user = Auth::user();

        if (!$user->role) {
            return response()->json([
                'status' => 'error',
                'message' => 'Asante kwa kujisajili. Maombi yako yanahitaji kuidhinishwa na uongozi wa kanisa. Tutakujulisha mara tu utakapokubalika.',
            ], 403);
        }

        $token = $user->createToken('auth_token')->plainTextToken;

        return response()->json([
            'status' => 'success',
            'message' => 'Login successful',
            'token' => $token,
            'user' => $user,
        ]);
    }

    /**
     * CHANGE PASSWORD
     */
    public function changePassword(Request $request)
    {
        $request->validate([
            'current_password' => 'required|string',
            'new_password' => 'required|string|min:6|confirmed',
        ]);

        if (!Hash::check($request->current_password, $request->user()->password)) {
            return response()->json(['status' => 'error', 'message' => 'Current password is incorrect.'], 400);
        }

        $request->user()->update([
            'password' => Hash::make($request->new_password),
        ]);

        return response()->json(['status' => 'success', 'message' => 'Password changed successfully.']);
    }

    /**
     * LOGOUT
     */
    public function logout(Request $request)
    {
        $request->user()->currentAccessToken()->delete();

        return response()->json([
            'status' => 'success',
            'message' => 'Logged out successfully',
        ]);
    }

    /**
     * ME
     */
    public function me(Request $request)
    {
        $user = $request->user();
        $member = Member::with(['user', 'groups'])->where('user_id', $user->id)->first();

        return response()->json([
            'status' => 'success',
            'member' => $member,
        ]);
    }



    /**
     * ALL USERS
     */

    public function allUsers()
{
    try {
        $members = Member::with(['user', 'groups', 'user.leader.roles'])->get();

        $users = $members->map(function ($member) {
            $user = $member->user;

            return [
                'id' => $user->id,
                'full_name' => $member->full_name ?? $user->full_name,
                'email' => $member->email ?? $user->email,
                'phone' => $member->phone_number ?? $user->phone,
                'gender' => $member->gender ?? $user->gender,
                'birth_date' => $member->birth_date ?? $user->birth_date,
                'birth_place' => $member->birth_place ?? $user->birth_place,
                'role' => $user->role,
                'leadership_roles' => $user->leader?->roles->pluck('title') ?? collect(),
                'created_at' => $user->created_at,
                'member_id' => $member->id,
                'residential_zone' =>
                    $member->residential_zone
                    ?? $user->zone
                    ?? null,
                'membership_status' => $member->membership_status,
                'membership_number' => $member->membership_number,
                'deactivation_reason' => $member->deactivation_reason,
                'groups' => $member->groups->map(fn ($group) => [
                    'id' => $group->id,
                    'name' => $group->name,
                ]),
            ];
        });

        $nonMembers = User::doesntHave('member')
            ->with('leader.roles') // eager load leader roles for non-members
            ->get()
            ->map(function ($user) {
                return [
                    'id' => $user->id,
                    'full_name' => $user->full_name,
                    'email' => $user->email,
                    'phone' => $user->phone,
                    'gender' => $user->gender,
                    'birth_date' => $user->birth_date,
                    'birth_place' => $user->birth_place,
                    'role' => $user->role,
                    'leadership_roles' => $user->leader?->roles->pluck('title') ?? collect(),
                    'created_at' => $user->created_at,
                    'member_id' => null,
                    'membership_status' => 'pending',
                    'deactivation_reason' => null,
                    'groups' => [],
                ];
            });

        return response()->json([
            'status' => 'success',
            'users' => $users->merge($nonMembers),
        ]);
    } catch (\Throwable $e) {
        return response()->json([
            'status' => 'error',
            'message' => 'Server error: ' . $e->getMessage(),
        ], 500);
    }
}


    /**
 * FORGOT PASSWORD
 */
public function forgotPassword(Request $request)
{
    $request->validate([
        'email' => 'required|email|exists:users,email',
    ]);

    $status = Password::sendResetLink(
        $request->only('email')
    );

    if ($status === Password::RESET_LINK_SENT) {
        return response()->json([
            'status' => 'success',
            'message' => 'Password reset link sent to your email.',
        ]);
    }

    return response()->json([
        'status' => 'error',
        'message' => 'Unable to send reset link.',
    ], 500);
}


/**
 * RESET PASSWORD
 */
/**
 * RESET PASSWORD (without token)
 */
public function resetPassword(Request $request)
{
    $request->validate([
        'email' => 'required|email|exists:users,email',
        'password' => 'required|string|min:6|confirmed',
    ]);

    // Find user by email
    $user = User::where('email', $request->email)->first();

    if (!$user) {
        return response()->json([
            'status' => 'error',
            'message' => 'User not found.',
        ], 404);
    }

    // Update password directly
    $user->update([
        'password' => Hash::make($request->password),
        'remember_token' => Str::random(60),
    ]);

    return response()->json([
        'status' => 'success',
        'message' => 'Password reset successfully.',
    ]);
}

public function rejectUser(Request $request, int $id)
{
    $request->validate([
        'reason' => 'required|string|max:255', // admin must provide a reason
    ]);

    $user = User::find($id);

    if (!$user) {
        return response()->json([
            'status' => 'error',
            'message' => 'User not found'
        ], 404);
    }

    $member = $user->member;

    if (!$member) {
        return response()->json([
            'status' => 'error',
            'message' => 'Member profile not found'
        ], 404);
    }

    // Save the actual reason
    $member->update([
        'membership_status' => 'rejected',
        'deactivation_reason' => $request->reason,
    ]);

    // Optionally remove role
    $user->role = null;
    $user->save();

    return response()->json([
        'status' => 'success',
        'message' => 'Member rejected successfully',
        'member' => $member,
        'user' => $user
    ]);
}
}

