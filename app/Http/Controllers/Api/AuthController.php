<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Leader;
use App\Models\Member;
use App\Models\User;
use App\Notifications\NewUserRegistered;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Password;
use Illuminate\Support\Str;
use Illuminate\Validation\Rule;
use Illuminate\Validation\ValidationException;

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
            return '255'.$num;
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

        $zoneValues = ['MURUBOMBO', 'MURUSI B', 'KIGANAMO', 'MURUSI A', 'KUMUNYIKA B', 'KAGUNGA C', 'KUMUNYIKA A', 'KAGUNGA B', 'MURUBONA A', 'KAGUNGA A', 'MURUBONA B'];

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
                'unique:users,phone',
            ],
            'whatsapp_number' => [
                'nullable',
                'regex:/^(0[0-9]{9}|255[0-9]{9})$/',
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
            'family_role' => 'nullable|string|max:255',
            'live_with_who' => 'nullable|string|max:255',
            'next_of_kin' => 'nullable|string|max:255',
            'next_of_kin_phone' => 'nullable|string|max:255',
        ]);

        try {
            [$user, $token] = DB::transaction(function () use ($request) {
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

                    // Personal
                    'full_name' => $request->full_name,
                    'gender' => $request->gender,
                    'birth_date' => $request->birth_date,
                    'birth_place' => $request->birth_place,
                    'birth_region' => $request->birth_region,
                    'birth_district' => $request->birth_district,
                    'birth_ward' => $request->birth_ward,
                    'birth_street' => $request->birth_street,

                    // Contact
                    'phone_number' => $request->phone,
                    'whatsapp_number' => $request->whatsapp_number,
                    'email' => $request->email,

                    // Family
                    'marital_status' => $request->marital_status,
                    'marriage_type' => $request->marriage_type,
                    'spouse_name' => $request->spouse_name,
                    'number_of_children' => $request->children_count,
                    'residential_zone' => $request->zone,
                    'residential_ward' => $request->residential_ward,
                    'residential_street' => $request->residential_street,

                    // Disability
                    'has_disability' => $request->has_disability ?? false,
                    'disability_description' => $request->disability_description,

                    // Faith
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
                    'previous_church_status' => $request->previous_church_status,
                    'tangu_lini' => $request->tangu_lini,
                    'kanisa_ulipotoka' => $request->kanisa_ulipotoka,

                    'church_service' => $request->church_service,
                    'service_duration' => $request->service_duration,
                    'participates_communion' => $request->participates_communion,

                    // Education
                    'education_level' => $request->education_level,
                    'profession' => $request->profession,
                    'occupation' => $request->occupation,
                    'work_place' => $request->work_place,
                    'work_contact' => $request->work_contact,

                    // Family
                    'lives_alone' => $request->lives_alone,
                    'lives_with' => $request->lives_with,
                    'family_role' => $request->family_role,
                    'live_with_who' => $request->live_with_who,
                    'next_of_kin' => $request->next_of_kin,
                    'next_of_kin_phone' => $request->next_of_kin_phone,

                    'membership_status' => 'pending',
                ]);

                $token = $user->createToken('auth_token')->plainTextToken;

                return [$user, $token];
            });

            // Notify admins after the registration transaction succeeds.
            $notificationStatus = [];
            $admins = User::where('role', 'admin')->get();
            foreach ($admins as $admin) {
                try {
                    $admin->notify(new NewUserRegistered($user));
                    $notificationStatus[$admin->email] = 'sent';
                } catch (\Throwable $ex) {
                    $notificationStatus[$admin->email] = 'failed: '.$ex->getMessage();
                }
            }

            return response()->json([
                'status' => 'success',
                'message' => 'User registered and member profile created successfully.',
                'token' => $token,
                'user' => $user,
            ]);
        } catch (\Throwable $e) {
            return response()->json([
                'status' => 'error',
                'message' => 'Server error: '.$e->getMessage(),
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
        $zoneValues = ['MURUBOMBO', 'MURUSI B', 'KIGANAMO', 'MURUSI A', 'KUMUNYIKA B', 'KAGUNGA C', 'KUMUNYIKA A', 'KAGANGA B', 'MURUBONA A', 'KAGUNGA A', 'KAGUNGA B', 'MURUBONA B'];

        $request->validate([
            'full_name' => 'required|string|max:255',
            'gender' => 'required|in:M,F',
            'birth_date' => 'nullable|date',
            'birth_place' => 'nullable|string|max:255',
            'birth_region' => 'nullable|string|max:255',
            'birth_ward' => 'nullable|string|max:255',
            'birth_street' => 'nullable|string|max:255',
            'marital_status' => ['nullable', Rule::in(['Ameoa', 'Ameolewa', 'Hajaoa', 'Hajaolewa', 'Mjane', 'Mgane'])],
            'marriage_type' => 'nullable|in:Kikristo,Kiserikali,Kienyeji',
            'spouse_name' => 'sometimes|required_if:marital_status,Ameoa,Ameolewa|string|max:255',
            'children_count' => 'nullable|integer|min:0',
            'zone' => ['nullable', Rule::in($zoneValues)],
            'residential_ward' => 'nullable|string|max:255',
            'residential_street' => 'nullable|string|max:255',
            'phone' => ['required', 'string', 'max:20', 'unique:users,phone,'.$user->id],
            'email' => ['required', 'email', 'max:255', 'unique:users,email,'.$user->id],

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
                'message' => 'Server error: '.$e->getMessage(),
            ], 500);
        }
    }

    /**
     * UPDATE USER
     */
    public function updateUser(Request $request, $id)
    {
        $user = User::with('member')->findOrFail($id);

        $request->merge([
            'marital_status' => $request->has('marital_status') ? trim((string) $request->marital_status) : $user->marital_status,
            'gender' => match ($request->gender ?? $user->gender) {
                'Mwanaume' => 'M',
                'Mwanamke' => 'F',
                default => $request->gender ?? $user->gender,
            },
            'phone' => $request->has('phone') ? $this->formatTanzaniaPhone($request->phone ?? '') : $user->phone,
        ]);

        $zoneValues = ['MURUBOMBO', 'MURUSI B', 'KIGANAMO', 'MURUSI A', 'KUMUNYIKA B', 'KAGUNGA C', 'KUMUNYIKA A', 'KAGANGA B', 'MURUBONA A', 'KAGUNGA A', 'KAGUNGA B', 'MURUBONA B'];

        $validated = $request->validate([
            'full_name' => 'sometimes|required|string|max:255',
            'gender' => 'sometimes|required|in:M,F',
            'birth_date' => 'nullable|date',
            'birth_place' => 'nullable|string|max:255',
            'birth_region' => 'nullable|string|max:255',
            'birth_district' => 'nullable|string|max:255',
            'birth_ward' => 'nullable|string|max:255',
            'birth_street' => 'nullable|string|max:255',
            'marital_status' => ['nullable', Rule::in(['Ameoa', 'Ameolewa', 'Hajaoa', 'Hajaolewa', 'Mjane', 'Mgane'])],
            'marriage_type' => 'nullable|in:Kikristo,Kiserikali,Kienyeji',
            'spouse_name' => 'nullable|string|max:255|required_if:marital_status,Ameoa,Ameolewa',
            'children_count' => 'nullable|integer|min:0',
            'zone' => ['nullable', Rule::in($zoneValues)],
            'residential_ward' => 'nullable|string|max:255',
            'residential_street' => 'nullable|string|max:255',
            'phone' => ['sometimes', 'required', 'string', 'max:20', 'unique:users,phone,'.$user->id],
            'whatsapp_number' => 'nullable|string|max:20',
            'email' => ['sometimes', 'required', 'email', 'max:255', 'unique:users,email,'.$user->id],
            'role' => 'nullable|in:admin,kiongozi,mshirika',
            'has_disability' => 'nullable|boolean',
            'disability_description' => 'nullable|string|max:500|required_if:has_disability,true,1',
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
            'education_level' => 'nullable|string',
            'profession' => 'nullable|string',
            'occupation' => 'nullable|string',
            'work_place' => 'nullable|string',
            'work_contact' => 'nullable|string',
            'lives_alone' => 'nullable|boolean',
            'lives_with' => 'nullable|string',
        ]);

        DB::beginTransaction();
        try {
            $userFields = [
                'full_name',
                'gender',
                'birth_date',
                'birth_place',
                'birth_region',
                'birth_district',
                'birth_ward',
                'birth_street',
                'marital_status',
                'marriage_type',
                'spouse_name',
                'children_count',
                'zone',
                'residential_ward',
                'residential_street',
                'phone',
                'whatsapp_number',
                'email',
                'has_disability',
                'disability_description',
                'role',
            ];

            $user->update(collect($validated)->only($userFields)->all());

            $member = $user->member;
            if ($member) {
                $memberData = collect($validated)->only([
                    'full_name',
                    'gender',
                    'birth_date',
                    'birth_place',
                    'birth_region',
                    'birth_district',
                    'birth_ward',
                    'birth_street',
                    'marital_status',
                    'marriage_type',
                    'spouse_name',
                    'whatsapp_number',
                    'email',
                    'has_disability',
                    'disability_description',
                    'date_of_conversion',
                    'conversion_year',
                    'conversion_month',
                    'conversion_day',
                    'church_of_conversion',
                    'baptism_date',
                    'baptism_year',
                    'baptism_month',
                    'baptism_day',
                    'baptism_place',
                    'baptizer_name',
                    'baptizer_title',
                    'previous_church',
                    'church_service',
                    'service_duration',
                    'participates_communion',
                    'education_level',
                    'profession',
                    'occupation',
                    'work_place',
                    'work_contact',
                    'lives_alone',
                    'lives_with',
                ])->all();

                if (array_key_exists('children_count', $validated)) {
                    $memberData['number_of_children'] = $validated['children_count'];
                }

                if (array_key_exists('zone', $validated)) {
                    $memberData['residential_zone'] = $validated['zone'];
                }

                if (array_key_exists('phone', $validated)) {
                    $memberData['phone_number'] = $validated['phone'];
                }

                if (array_key_exists('residential_ward', $validated)) {
                    $memberData['residential_ward'] = $validated['residential_ward'];
                }

                if (array_key_exists('residential_street', $validated)) {
                    $memberData['residential_street'] = $validated['residential_street'];
                }

                $member->update($memberData);
            }

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'User updated successfully.',
                'user' => $user->fresh()->load('member'),
            ]);
        } catch (\Throwable $e) {
            DB::rollBack();

            return response()->json([
                'status' => 'error',
                'message' => 'Server error: '.$e->getMessage(),
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

        $loginInput = trim($request->login);

        // Detect email or phone
        if (filter_var($loginInput, FILTER_VALIDATE_EMAIL)) {
            $fieldType = 'email';
        } else {
            $fieldType = 'phone';

            // Normalize phone number
            $loginInput = preg_replace('/\D/', '', $loginInput);

            // Convert 0712... -> 255712...
            if (str_starts_with($loginInput, '0')) {
                $loginInput = '255'.substr($loginInput, 1);
            }

            // Convert +255712... -> 255712...
            if (str_starts_with($request->login, '+255')) {
                $loginInput = substr($request->login, 1);
            }
        }

        if (! Auth::attempt([
            $fieldType => $loginInput,
            'password' => $request->password,
        ])) {
            return response()->json([
                'status' => 'error',
                'message' => 'Email/Simu au neno la siri si sahihi',
            ], 401);
        }

        $user = Auth::user();

        if (! $user->role) {
            return response()->json([
                'status' => 'error',
                'message' => 'Asante kwa kujisajili. Maombi yako yanahitaji kuidhinishwa.',
            ], 403);
        }

        $leadershipRoles = [];

        if ($user->role === 'kiongozi') {
            $leader = Leader::with('roles')
                ->where('user_id', $user->id)
                ->first();

            if ($leader) {
                $leadershipRoles = $leader->roles->pluck('title')->toArray();
            }
        }

        $token = $user->createToken('auth_token')->plainTextToken;

        return response()->json([
            'status' => 'success',
            'message' => 'Login successful',
            'token' => $token,
            'user' => $user,
            'leadership_roles' => $leadershipRoles,
        ]);
    }

    /**
     * CHANGE PASSWORD
     */
    public function changePassword(Request $request)
    {
        $request->validate([
            'current_password' => ['required', 'string'],
            'new_password' => [
                'required',
                'string',
                'min:6',
                'different:current_password',
                'regex:/[A-Za-z]/',
                'regex:/[0-9]/',
                'regex:/[^A-Za-z0-9]/',
            ],
            'new_password_confirmation' => ['required', 'string', 'same:new_password'],
        ], [
            'current_password.required' => 'Password ya sasa inahitajika.',
            'new_password.required' => 'Password mpya inahitajika.',
            'new_password.min' => 'Password mpya lazima iwe na angalau herufi 6.',
            'new_password.different' => 'Password mpya haiwezi kufanana na password ya sasa.',
            'new_password.regex' => 'Password mpya lazima iwe na herufi, namba, na alama maalum.',
            'new_password_confirmation.required' => 'Uthibitisho wa password mpya unahitajika.',
            'new_password_confirmation.same' => 'Uthibitisho wa password haujalingana.',
        ]);

        $user = $request->user();

        if (!$user) {
            return response()->json([
                'status' => 'error',
                'message' => 'Mtumiaji hajathibitishwa.',
            ], 401);
        }

        if (!Hash::check($request->current_password, $user->password)) {
            throw ValidationException::withMessages([
                'current_password' => ['Password ya sasa si sahihi.'],
            ]);
        }

        $user->update([
            'password' => Hash::make($request->new_password),
        ]);

        return response()->json([
            'status' => 'success',
            'message' => 'Password imebadilishwa kikamilifu. Tafadhali ingia tena.',
        ]);
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

        $member = Member::with([
            'user',
            'groups:id,name,whatsapp_link',
        ])->where('user_id', $user->id)->first();

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
                    'residential_zone' => $member->residential_zone
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
                'message' => 'Server error: '.$e->getMessage(),
            ], 500);
        }
    }

    public function pendingRegistrations(Request $request)
    {
        $limit = min(max((int) $request->input('limit', 10), 1), 100);
        $query = Member::query()
            ->with('user')
            ->where('membership_status', 'pending')
            ->where('is_authorized', false)
            ->whereHas('user', fn ($query) => $query->whereNull('role'));

        return response()->json([
            'status' => 'success',
            'count' => (clone $query)->count(),
            'pending_registrations' => $query->latest()->limit($limit)->get(),
        ]);
    }

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

    public function resetPassword(Request $request)
    {
        $request->validate([
            'email' => 'required|email|exists:users,email',
            'password' => 'required|string|min:6|confirmed',
        ]);

        // Find user by email
        $user = User::where('email', $request->email)->first();

        if (! $user) {
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

        if (! $user) {
            return response()->json([
                'status' => 'error',
                'message' => 'User not found',
            ], 404);
        }

        $member = $user->member;

        if (! $member) {
            return response()->json([
                'status' => 'error',
                'message' => 'Member profile not found',
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
            'user' => $user,
        ]);
    }
}
