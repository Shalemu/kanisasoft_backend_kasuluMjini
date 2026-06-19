<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Mail\MemberAuthorizedMail;
use App\Models\Contribution;
use App\Models\DeletedMember;
use App\Models\Guest;
use App\Models\Group;
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
use Illuminate\Support\Str;
use Illuminate\Validation\Rule;

class MembersController extends Controller
{
    private const MARITAL_STATUSES = ['Ameoa', 'Ameolewa', 'Hajaoa', 'Hajaolewa', 'Mjane', 'Mgane'];

    private const MEMBERSHIP_STATUS_LABELS = [
        'active' => 'Washirika',
        'pending' => 'Wanaosubiri Kuidhinishwa',
        'rejected' => 'Waliokataliwa ushirika',
        'deactivated' => 'Wasio hai',
        'left' => 'Waliohama',
        'detained' => 'Waliotengwa ushirika',
        'deceased' => 'Waliofariki',
        'lost' => 'Waliopoteza ushirika',
    ];

    private const EXACT_FILTER_FIELDS = [
        'full_name',
        'membership_number',
        'gender',
        'phone_number',
        'whatsapp_number',
        'email',
        'marital_status',
        'marriage_type',
        'spouse_name',
        'birth_place',
        'birth_region',
        'birth_district',
        'birth_ward',
        'birth_street',
        'residential_zone',
        'residential_ward',
        'residential_street',
        'disability_description',
        'church_of_conversion',
        'baptism_place',
        'baptizer_name',
        'baptizer_title',
        'previous_church',
        'previous_church_status',
        'tangu_lini',
        'church_service',
        'service_duration',
        'education_level',
        'profession',
        'occupation',
        'work_place',
        'work_contact',
        'lives_with',
        'family_role',
        'live_with_who',
        'next_of_kin',
        'next_of_kin_phone',
        'verified_by',
        'membership_status',
        'deactivation_reason',
    ];

    private const BOOLEAN_FILTER_FIELDS = [
        'has_disability',
        'lives_alone',
        'participates_communion',
        'is_authorized',
    ];

    private const DATE_FILTER_FIELDS = [
        'birth_date',
        'date_of_conversion',
        'baptism_date',
        'membership_start_date',
        'created_at',
    ];

    private const NUMERIC_FILTER_FIELDS = [
        'number_of_children',
        'conversion_year',
        'conversion_month',
        'conversion_day',
        'baptism_year',
        'baptism_month',
        'baptism_day',
    ];

    private const SEARCHABLE_FIELDS = [
        'full_name',
        'membership_number',
        'phone_number',
        'whatsapp_number',
        'email',
        'birth_place',
        'birth_region',
        'birth_district',
        'birth_ward',
        'birth_street',
        'spouse_name',
        'residential_zone',
        'residential_ward',
        'residential_street',
        'disability_description',
        'church_of_conversion',
        'baptism_place',
        'baptizer_name',
        'baptizer_title',
        'previous_church',
        'previous_church_status',
        'tangu_lini',
        'church_service',
        'service_duration',
        'education_level',
        'profession',
        'occupation',
        'work_place',
        'work_contact',
        'lives_with',
        'family_role',
        'live_with_who',
        'next_of_kin',
        'next_of_kin_phone',
        'verified_by',
        'membership_status',
        'deactivation_reason',
    ];

    /**
     * List all members
     */
    public function index(Request $request)
    {
        $members = $this->filteredMembersQuery($request)
            ->with('user')
            ->orderByRaw('membership_number IS NULL')
            ->orderByRaw('membership_number + 0 ASC')
            ->orderBy('id')
            ->get();

        return response()->json([
            'status' => 'success',
            'membership_status_labels' => self::MEMBERSHIP_STATUS_LABELS,
            'members' => $members,
        ]);
    }

    public function report(Request $request)
    {
        $criteria = $this->normalizedMemberFilters($request);

        $members = $this->filteredMembersQuery($request, $criteria)
            ->with(['user', 'groups:id,name'])
            ->orderByRaw('membership_number IS NULL')
            ->orderByRaw('membership_number + 0 ASC')
            ->orderBy('id')
            ->get();

        $statusCounts = $members->groupBy(fn ($member) => $member->membership_status ?? 'unknown')
            ->map->count();
        $genderCounts = $members->groupBy(fn ($member) => $member->gender ?? 'unknown')
            ->map->count();
        $zoneCounts = $members->groupBy(fn ($member) => $member->residential_zone ?? 'Haijajazwa')
            ->map->count();

        return response()->json([
            'status' => 'success',
            'filters' => $criteria,
            'saved_group_criteria' => $this->groupableCriteria($criteria),
            'membership_status_labels' => self::MEMBERSHIP_STATUS_LABELS,
            'summary' => [
                'total_members' => $members->count(),
                'active_members' => $statusCounts->get('active', 0),
                'pending_members' => $statusCounts->get('pending', 0),
                'deactivated_members' => $members->whereNotIn('membership_status', ['active', 'pending', 'rejected'])->count(),
                'by_status' => $statusCounts,
                'by_gender' => $genderCounts,
                'by_zone' => $zoneCounts,
            ],
            'total' => $members->count(),
            'export' => [
                'columns' => [
                    'membership_number', 'full_name', 'gender', 'phone_number', 'email',
                    'marital_status', 'education_level', 'occupation', 'residential_zone',
                    'membership_status', 'membership_start_date',
                ],
                'rows' => $members->map(fn ($member) => [
                    'membership_number' => $member->membership_number,
                    'full_name' => $member->full_name,
                    'gender' => $member->gender,
                    'phone_number' => $member->phone_number,
                    'email' => $member->email,
                    'marital_status' => $member->marital_status,
                    'education_level' => $member->education_level,
                    'occupation' => $member->occupation,
                    'residential_zone' => $member->residential_zone,
                    'membership_status' => $member->membership_status,
                    'membership_start_date' => optional($member->membership_start_date)->format('Y-m-d'),
                ]),
            ],
            'members' => $members,
        ]);
    }

    public function createGroupFromSearch(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255|unique:groups,name',
            'leader_membership_number' => 'nullable|string',
            'leader_member_id' => 'nullable|integer|exists:members,id',
            'leader_id' => 'nullable|integer|exists:members,id',
            'leader_name' => 'nullable|string|max:255',
            'whatsapp_link' => 'nullable|url',
        ]);

        $criteria = $this->normalizedMemberFilters($request);
        $groupCriteria = $this->groupableCriteria($criteria);

        $leaderId = $request->integer('leader_member_id') ?: ($request->integer('leader_id') ?: null);
        if ($request->filled('leader_membership_number')) {
            $leader = Member::where('membership_number', $this->normalizeMembershipNumber($request->leader_membership_number))->first();
            if (! $leader) {
                return response()->json([
                    'status' => 'error',
                    'message' => 'Huyo mshirika hana namba ya ushirika.',
                ], 404);
            }
            $leaderId = $leader->id;
        }
        if (! $leaderId && $request->filled('leader_name')) {
            $leaders = Member::where('full_name', 'like', '%'.trim($request->leader_name).'%')->get();

            if ($leaders->count() > 1) {
                return response()->json([
                    'status' => 'error',
                    'message' => 'Zaidi ya mshirika mmoja amepatikana kwa jina hilo. Tafadhali chagua mshirika maalum.',
                    'matches' => $leaders->map(fn ($member) => [
                        'id' => $member->id,
                        'member_id' => $member->id,
                        'full_name' => $member->full_name,
                        'membership_number' => $member->membership_number,
                    ]),
                ], 422);
            }

            if ($leaders->isEmpty()) {
                return response()->json([
                    'status' => 'error',
                    'message' => 'Hakuna mshirika aliyepatikana kwa jina hilo.',
                ], 404);
            }

            $leaderId = $leaders->first()->id;
        }

        $memberIds = $this->filteredMembersQuery($request, $criteria)
            ->where('membership_status', 'active')
            ->pluck('id');

        if ($memberIds->isEmpty()) {
            return response()->json([
                'status' => 'error',
                'message' => 'Hakuna washirika waliopatikana kwa vigezo hivyo.',
            ], 422);
        }

        $group = DB::transaction(function () use ($request, $leaderId, $groupCriteria, $memberIds) {
            $group = Group::create([
                'name' => $request->name,
                'leader_id' => $leaderId,
                'whatsapp_link' => $request->whatsapp_link,
                'filter_criteria' => $groupCriteria,
            ]);

            $group->members()->syncWithoutDetaching($memberIds->all());

            return $group->fresh(['leader'])->loadCount('members');
        });

        return response()->json([
            'status' => 'success',
            'message' => 'Kundi limetengenezwa na washirika wameongezwa.',
            'group' => $group,
            'assigned_members_count' => $memberIds->count(),
            'filter_criteria' => $groupCriteria,
        ], 201);
    }

    private function filteredMembersQuery(Request $request, ?array $criteria = null)
    {
        $criteria ??= $this->normalizedMemberFilters($request);
        $query = Member::query();

        foreach (self::EXACT_FILTER_FIELDS as $field) {
            $this->applyExactFilter($query, $field, $criteria[$field] ?? null);
        }

        foreach (self::BOOLEAN_FILTER_FIELDS as $field) {
            if (array_key_exists($field, $criteria)) {
                $query->where($field, $criteria[$field]);
            }
        }

        foreach (self::NUMERIC_FILTER_FIELDS as $field) {
            if (array_key_exists($field, $criteria)) {
                $query->where($field, $criteria[$field]);
            }
            if (array_key_exists($field.'_min', $criteria)) {
                $query->where($field, '>=', $criteria[$field.'_min']);
            }
            if (array_key_exists($field.'_max', $criteria)) {
                $query->where($field, '<=', $criteria[$field.'_max']);
            }
        }

        foreach (self::DATE_FILTER_FIELDS as $field) {
            if (array_key_exists($field, $criteria)) {
                $query->whereDate($field, $criteria[$field]);
            }
            if (array_key_exists($field.'_from', $criteria)) {
                $query->whereDate($field, '>=', $criteria[$field.'_from']);
            }
            if (array_key_exists($field.'_to', $criteria)) {
                $query->whereDate($field, '<=', $criteria[$field.'_to']);
            }
        }

        if (array_key_exists('birth_month', $criteria)) {
            $query->whereMonth('birth_date', $criteria['birth_month']);
        }

        if (array_key_exists('conversion_month', $criteria)) {
            $query->where('conversion_month', $criteria['conversion_month']);
        }

        if (array_key_exists('baptism_month', $criteria)) {
            $query->where('baptism_month', $criteria['baptism_month']);
        }

        if (! empty($criteria['search'])) {
            $search = $criteria['search'];
            $query->where(function ($query) use ($search) {
                foreach (self::SEARCHABLE_FIELDS as $index => $field) {
                    $method = $index === 0 ? 'where' : 'orWhere';
                    $query->{$method}($field, 'like', "%{$search}%");
                }

                $this->orWhereNormalizedMembershipNumberLike($query, $search);
            });
        }

        return $query;
    }

    private function normalizedMemberFilters(Request $request): array
    {
        $request->validate($this->memberFilterRules($request));

        $filters = [];

        foreach (self::EXACT_FILTER_FIELDS as $field) {
            if ($request->filled($field)) {
                $filters[$field] = $field === 'gender'
                    ? $this->normalizeGender($request->input($field))
                    : $request->input($field);
            }
        }

        foreach (self::BOOLEAN_FILTER_FIELDS as $field) {
            if ($request->has($field) && $request->input($field) !== null && $request->input($field) !== '') {
                $filters[$field] = $request->boolean($field);
            }
        }

        foreach (self::NUMERIC_FILTER_FIELDS as $field) {
            foreach ([$field, $field.'_min', $field.'_max'] as $key) {
                if ($request->filled($key)) {
                    $filters[$key] = (int) $request->input($key);
                }
            }
        }

        foreach (self::DATE_FILTER_FIELDS as $field) {
            foreach ([$field, $field.'_from', $field.'_to'] as $key) {
                if ($request->filled($key)) {
                    $filters[$key] = $request->input($key);
                }
            }
        }

        $aliasMap = [
            'zone' => 'residential_zone',
            'date_from' => 'created_at_from',
            'from_date' => 'created_at_from',
            'date_to' => 'created_at_to',
            'to_date' => 'created_at_to',
        ];

        foreach ($aliasMap as $alias => $target) {
            if ($request->filled($alias) && ! array_key_exists($target, $filters)) {
                $filters[$target] = $request->input($alias);
            }
        }

        $birthMonth = $request->input('birth_month');
        if (! $birthMonth && $request->boolean('birthdays_this_month')) {
            $birthMonth = now()->month;
        }
        if ($birthMonth) {
            $filters['birth_month'] = (int) $birthMonth;
        }

        if ($request->filled('search')) {
            $filters['search'] = trim($request->input('search'));
        }

        return $filters;
    }

    private function memberFilterRules(Request $request): array
    {
        $rules = [
            'gender' => 'nullable|in:M,F,Mwanaume,Mwanamke',
            'birth_month' => 'nullable|integer|between:1,12',
            'birthdays_this_month' => 'nullable|boolean',
            'zone' => 'nullable|string|max:255',
            'from_date' => 'nullable|date',
            'to_date' => 'nullable|date',
            'date_from' => 'nullable|date',
            'date_to' => 'nullable|date',
            'search' => 'nullable|string|max:255',
        ];

        foreach (array_diff(self::EXACT_FILTER_FIELDS, ['gender']) as $field) {
            $rules[$field] = 'nullable|string|max:255';
        }

        foreach (self::BOOLEAN_FILTER_FIELDS as $field) {
            $rules[$field] = 'nullable|boolean';
        }

        foreach (self::NUMERIC_FILTER_FIELDS as $field) {
            $rules[$field] = 'nullable|integer';
            $rules[$field.'_min'] = 'nullable|integer';
            $rules[$field.'_max'] = 'nullable|integer';
        }

        foreach (self::DATE_FILTER_FIELDS as $field) {
            $rules[$field] = 'nullable|date';
            $rules[$field.'_from'] = 'nullable|date';
            $rules[$field.'_to'] = 'nullable|date';
        }

        return $rules;
    }

    private function groupableCriteria(array $criteria): array
    {
        return collect($criteria)
            ->except([
                'search',
                'created_at',
                'created_at_from',
                'created_at_to',
            ])
            ->filter(fn ($value) => $value !== null && $value !== '')
            ->all();
    }

    private function applyExactFilter($query, string $field, mixed $value): void
    {
        if ($value === null || $value === '') {
            return;
        }

        $query->where($field, $value);
    }

    private function normalizeGender(?string $gender): ?string
    {
        return match ($gender) {
            'Mwanaume' => 'M',
            'Mwanamke' => 'F',
            default => $gender,
        };
    }

    private function normalizeMembershipNumber(string|int $number): string
    {
        return str_pad((int) preg_replace('/\D/', '', (string) $number), 4, '0', STR_PAD_LEFT);
    }

    private function normalizedMembershipSearchTerm(string $search): ?string
    {
        if (! preg_match('/^\d+$/', trim($search))) {
            return null;
        }

        $normalized = ltrim(trim($search), '0');

        return $normalized === '' ? '0' : $normalized;
    }

    private function orWhereNormalizedMembershipNumberLike($query, string $search): void
    {
        $normalizedSearch = $this->normalizedMembershipSearchTerm($search);

        if ($normalizedSearch === null) {
            return;
        }

        $driver = DB::connection()->getDriverName();
        $expression = $driver === 'mysql'
            ? "COALESCE(NULLIF(TRIM(LEADING '0' FROM membership_number), ''), '0')"
            : "COALESCE(NULLIF(ltrim(membership_number, '0'), ''), '0')";

        $query->orWhereRaw($expression.' like ?', ['%'.$normalizedSearch.'%']);
    }

    private function assignMemberToMatchingGroups(Member $member): array
    {
        if ($member->membership_status !== 'active') {
            return [];
        }

        $matched = [];

        foreach (Group::whereNotNull('filter_criteria')->get() as $group) {
            $criteria = $group->filter_criteria ?: [];
            if ($criteria === [] || ! $this->memberMatchesCriteria($member, $criteria)) {
                continue;
            }

            $group->members()->syncWithoutDetaching([$member->id]);
            $matched[] = [
                'id' => $group->id,
                'name' => $group->name,
            ];
        }

        return $matched;
    }

    private function memberMatchesCriteria(Member $member, array $criteria): bool
    {
        return $this->filteredMembersQuery(new Request(), $criteria)
            ->whereKey($member->id)
            ->exists();
    }

    /**
     * Show a specific member
     */
    public function show(int $id)
    {
        $member = Member::with([
            'user',
            'groups:id,name,whatsapp_link',
            'marriageAsHusband.wife:id,full_name,membership_number',
            'marriageAsWife.husband:id,full_name,membership_number',
        ])->find($id);

        if (! $member) {
            return response()->json(['status' => 'error', 'message' => 'Member not found'], 404);
        }

        return response()->json([
            'status' => 'success',
            'member' => $member,
            'edit_data' => $member->toArray(),
        ]);
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
            'phone_number' => $request->phone_number
                ? $this->formatTanzaniaPhone($request->phone_number)
                : $request->phone_number,
            'number_of_children' => $request->input('number_of_children', $request->input('children_count')),
        ]);

        $request->merge([
            'marital_status' => $this->normalizeMaritalStatus($request->input('marital_status'), $request->input('gender')),
        ]);

        if (! in_array($request->marital_status, ['Ameoa', 'Ameolewa'], true)) {
            $request->merge(['spouse_name' => null]);
        }

        $zoneValues = ['MURUBOMBO', 'MURUSI B', 'KIGANAMO', 'MURUSI A', 'KUMUNYIKA B', 'KAGUNGA C', 'KUMUNYIKA A', 'KAGANGA B', 'KAGUNGA B', 'MURUBONA A', 'MURUBONA B', 'KAGUNGA A'];

        $validator = Validator::make($request->all(), [
            'full_name' => 'required|string|max:255',
            'gender' => 'required|in:M,F',
            'birth_date' => 'nullable|date',
            'birth_place' => 'nullable|string|max:255',
            'birth_region' => 'nullable|string|max:255',
            'birth_ward' => 'nullable|string|max:255',
            'birth_street' => 'nullable|string|max:255',
            'marital_status' => ['nullable', Rule::in(self::MARITAL_STATUSES)],
            'marriage_type' => 'nullable|in:Kikristo,Kiserikali,Kienyeji',
            'spouse_name' => 'nullable|string|max:255|required_if:marital_status,Ameoa,Ameolewa',
            'number_of_children' => 'nullable|integer|min:0',
            'residential_zone' => ['nullable', Rule::in($zoneValues)],
            'residential_ward' => 'nullable|string|max:255',
            'residential_street' => 'nullable|string|max:255',
            'phone_number' => ['required', 'regex:/^255[0-9]{9}$/', 'unique:users,phone'],
            'whatsapp_number' => ['nullable', 'regex:/^(0[0-9]{9}|255[0-9]{9})$/'],
            'email' => 'required|email|max:255|unique:users,email',
            'password' => 'nullable|string|min:6|confirmed',
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
                'children_count' => $request->number_of_children ?? 0,
                'zone' => $request->residential_zone,
                'residential_ward' => $request->residential_ward,
                'residential_street' => $request->residential_street,
                'phone' => $request->phone_number,
                'whatsapp_number' => $request->whatsapp_number,
                'email' => $request->email,
                'has_disability' => $request->has_disability ?? false,
                'disability_description' => $request->disability_description,
                'password' => Hash::make($request->password ?? Str::random(12)),
                'role' => 'mshirika',
            ]);

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
                'membership_number' => null,
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
                'message' => 'Server Error: '.$e->getMessage(),
            ], 500);
        }
    }

    public function byUser(int $userId)
    {
        $member = Member::where('user_id', $userId)->first();
        if (! $member) {
            return response()->json(['message' => 'Member not found'], 404);
        }

        return response()->json(['member' => $member]);
    }

    public function update(Request $request, Member $member)
    {
        $user = $member->user;

        /*
        |--------------------------------------------------------------------------
        | Normalize values
        |--------------------------------------------------------------------------
        */

        $gender = match ($request->gender ?? $member->gender) {
            'Mwanaume' => 'M',
            'Mwanamke' => 'F',
            default => $request->gender ?? $member->gender,
        };

        $maritalStatus = $this->normalizeMaritalStatus(
            $request->input('marital_status', $member->marital_status),
            $gender
        );

        $livesAlone = filter_var($request->lives_alone, FILTER_VALIDATE_BOOLEAN, FILTER_NULL_ON_FAILURE);
        $isAuthorized = filter_var($request->is_authorized, FILTER_VALIDATE_BOOLEAN, FILTER_NULL_ON_FAILURE);

        if (! in_array($maritalStatus, ['Ameoa', 'Ameolewa'])) {
            $request->merge(['spouse_name' => null]);
        }

        /*
        |--------------------------------------------------------------------------
        | Format phone
        |--------------------------------------------------------------------------
        */

        $formattedPhone = null;
        if ($request->filled('phone_number')) {
            $formattedPhone = $this->formatTanzaniaPhone($request->phone_number);

            if (! $this->isValidTanzaniaPhone($formattedPhone)) {
                return response()->json([
                    'status' => 'error',
                    'message' => 'Namba ya simu si sahihi. Tumia mfumo wa 0712345678 au 255712345678.',
                    'errors' => [
                        'phone_number' => ['Namba ya simu si sahihi.'],
                    ],
                ], 422);
            }
        }

        $formattedWhatsapp = null;
        if ($request->filled('whatsapp_number')) {
            $formattedWhatsapp = $this->formatTanzaniaPhone($request->whatsapp_number);

            if (! $this->isValidTanzaniaPhone($formattedWhatsapp)) {
                return response()->json([
                    'status' => 'error',
                    'message' => 'Namba ya WhatsApp si sahihi. Tumia mfumo wa 0712345678 au 255712345678.',
                    'errors' => [
                        'whatsapp_number' => ['Namba ya WhatsApp si sahihi.'],
                    ],
                ], 422);
            }
        }

        if ($request->filled('membership_number')) {
            $membershipNumberValue = (int) preg_replace('/\D/', '', $request->membership_number);
            if ($membershipNumberValue <= 0) {
                return response()->json([
                    'status' => 'error',
                    'message' => 'Namba ya ushirika si sahihi.',
                ], 422);
            }

            $normalizedMembershipNumber = str_pad($membershipNumberValue, 4, '0', STR_PAD_LEFT);
            $numberExists = Member::where('membership_number', $normalizedMembershipNumber)
                ->where('membership_status', 'active')
                ->where('id', '!=', $member->id)
                ->exists();

            if ($numberExists) {
                return response()->json([
                    'status' => 'error',
                    'message' => 'Namba ya ushirika tayari inatumiwa na mshirika mwingine.',
                ], 422);
            }

            $request->merge(['membership_number' => $normalizedMembershipNumber]);
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
                    'whatsapp_number' => $formattedWhatsapp ?: $user->whatsapp_number,
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
                    'whatsapp_number' => $formattedWhatsapp,
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
                'whatsapp_number' => $formattedWhatsapp ?: $member->whatsapp_number,
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
                'previous_church_status' => $request->previous_church_status ?? $member->previous_church_status,
                'tangu_lini' => $request->tangu_lini ?? $member->tangu_lini,
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

        [$user, $member] = DB::transaction(function () use ($request) {
            $user = User::lockForUpdate()->findOrFail($request->user_id);
            $member = Member::where('user_id', $user->id)->lockForUpdate()->first();

            if ($member) {
                $member->update([
                    'membership_status' => 'active',
                    'membership_number' => $member->membership_number ?? $this->generateMembershipNumber(),
                    'membership_start_date' => $member->membership_start_date ?? now()->toDateString(),
                    'is_authorized' => 1,
                ]);
            } else {
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
                    'membership_number' => $this->generateMembershipNumber(),
                    'membership_start_date' => now()->toDateString(),
                    'is_authorized' => 1,
                ]);
            }

            $user->update(['role' => 'mshirika']);

            return [$user, $member];
        });

        $this->notifyMember($member);
        $autoAssignedGroups = $this->assignMemberToMatchingGroups($member->fresh());

        return response()->json([
            'status' => 'success',
            'message' => 'User authorized as member successfully, notifications sent.',
            'member' => $member,
            'user' => $user,
            'auto_assigned_groups' => $autoAssignedGroups,
        ]);
    }

    /**
     * Activate member
     */
    public function activate(Member $member)
    {
        if ($member->membership_status === 'active') {
            return response()->json([
                'status' => 'info',
                'message' => 'Member already active.',
                'member' => $member,
            ]);
        }

        $member->update([
            'membership_status' => 'active',
            'deactivation_reason' => null,
            'membership_number' => $member->membership_number ?? $this->generateMembershipNumber(),
            'membership_start_date' => $member->membership_start_date ?? now()->toDateString(),
            'is_authorized' => true,
        ]);

        $this->notifyMember($member);
        $autoAssignedGroups = $this->assignMemberToMatchingGroups($member->fresh());

        return response()->json([
            'status' => 'success',
            'message' => 'Member activated successfully. Notifications sent.',
            'member' => $member->fresh()->load('user'),
            'auto_assigned_groups' => $autoAssignedGroups,
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
            'Amepoteza ushirika' => 'lost',
            'Amejisajiri kimakosa' => 'deactivated',
        ];

        $request->validate([
            'reason' => ['nullable', 'string', 'max:255'],
        ]);

        $reason = $request->input('reason', 'Deactivated by admin');
        $status = $reasons[$reason] ?? 'deactivated';

        $member->update([
            'membership_status' => $status,
            'deactivation_reason' => $reason,
            'is_authorized' => false,
            'membership_number' => null,
        ]);

        return response()->json([
            'status' => 'success',
            'message' => 'Member deactivated successfully.',
            'member' => $member->fresh()->load('user'),
            'membership_status' => $status,
        ]);
    }

    public function deactivateUser(Request $request, User $user)
    {
        $member = $user->member;

        if (! $member) {
            return response()->json([
                'status' => 'error',
                'message' => 'Member not found for this user.',
            ], 404);
        }

        return $this->deactivate($request, $member);
    }

    public function stats()
    {
        $guestCount = Guest::count();
        $totalContributions = (float) Contribution::sum('amount');
        $pendingRegistrations = Member::where('membership_status', 'pending')
            ->where('is_authorized', false)
            ->count();

        return response()->json([
            'status' => 'success',
            'total_members' => Member::where('membership_status', 'active')->count(),
            'total_visitors' => $guestCount,
            'total_guests' => $guestCount,
            'total_contributions' => $totalContributions,
            'pending_registrations' => $pendingRegistrations,
            'notification_count' => $pendingRegistrations,
            'membership_status_labels' => self::MEMBERSHIP_STATUS_LABELS,
            'modules' => [
                [
                    'key' => 'members',
                    'label' => 'Washirika',
                    'icon' => 'users',
                    'total' => Member::where('membership_status', 'active')->count(),
                ],
                [
                    'key' => 'visitors',
                    'label' => 'Wageni',
                    'icon' => 'user-plus',
                    'total' => $guestCount,
                ],
                [
                    'key' => 'reports',
                    'label' => 'Ripoti',
                    'icon' => 'file-text',
                    'total' => null,
                ],
                [
                    'key' => 'notifications',
                    'label' => 'Maombi Mapya',
                    'icon' => 'bell',
                    'total' => $pendingRegistrations,
                ],
                [
                    'key' => 'contributions',
                    'label' => 'Michango',
                    'icon' => 'wallet',
                    'total' => $totalContributions,
                ],
            ],
        ]);
    }

    public function destroy(Member $member)
    {
        return $this->deactivate(new Request(['reason' => 'Deactivated by admin']), $member);
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

        if (! $record) {
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

        if (! $member) {
            return response()->json(['status' => 'error', 'message' => 'Member not found'], 404);
        }

        try {
            $user = $member->user;

            DeletedMember::create([
                'user_id' => $user?->id,
                'full_name' => $member->full_name,
                'email' => $member->email,
                'phone' => $member->phone_number,
                'gender' => $member->gender,
                'birth_date' => $member->birth_date,
                'reason' => 'deleted manually',
                'deleted_by' => auth()->user()->full_name ?? 'system',
                'deleted_at' => now(),
            ]);

            $member->update([
                'membership_status' => 'deactivated',
                'deactivation_reason' => 'deleted manually',
                'is_authorized' => false,
                'membership_number' => null,
            ]);

            if ($user) {
                $user->update(['role' => null]);
            }

            return response()->json([
                'status' => 'success',
                'message' => 'Member deactivated successfully',
                'member' => $member->fresh()->load('user'),
            ]);
        } catch (\Throwable $e) {
            return response()->json([
                'status' => 'error',
                'message' => 'Error deleting user and member: '.$e->getMessage(),
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
        $usedNumbers = Member::query()
            ->whereNotNull('membership_number')
            ->where('membership_status', 'active')
            ->lockForUpdate()
            ->pluck('membership_number')
            ->map(fn ($number) => (int) $number)
            ->filter(fn ($number) => $number > 0)
            ->unique()
            ->sort()
            ->values();

        $newNumber = 1;
        foreach ($usedNumbers as $usedNumber) {
            if ($usedNumber === $newNumber) {
                $newNumber++;

                continue;
            }

            if ($usedNumber > $newNumber) {
                break;
            }
        }

        return str_pad($newNumber, 4, '0', STR_PAD_LEFT);
    }

    private function formatTanzaniaPhone(string $phone): string
    {
        $num = preg_replace('/\D/', '', $phone);

        if (str_starts_with($num, '0')) {
            return '255'.substr($num, 1);
        }

        if (strlen($num) === 9) {
            return '255'.$num;
        }

        return $num;
    }

    private function isValidTanzaniaPhone(?string $phone): bool
    {
        return $phone === null || (bool) preg_match('/^255[0-9]{9}$/', $phone);
    }

    private function normalizeMaritalStatus(?string $status, ?string $gender): ?string
    {
        $status = filled($status) ? trim($status) : null;

        return match ($status) {
            'Ndoa' => $gender === 'F' ? 'Ameolewa' : 'Ameoa',
            'Bila ndoa' => $gender === 'F' ? 'Hajaolewa' : 'Hajaoa',
            default => $status,
        };
    }

    /**
     * Notify member via SMS and Email
     */
    private function notifyMember(Member $member)
    {
        // Refresh member
        $member = $member->fresh();

        // Only generate membership number if member is active/approved
        if ($member->membership_status === 'active' && ! $member->membership_number) {
            $member->membership_number = $this->generateMembershipNumber();
            $member->save();
        }

        $membershipNumber = $member->membership_number ?? '—';
        $fullName = $member->full_name;

        // Send SMS
        if ($member->phone_number) {
            try {
                $text = "Habari {$fullName}, usajili wako   umekamilika. "
                      ."Namba yako ya ushirika ni: {$membershipNumber}. Karibu  KanisaSoft.";

                app(SMSService::class)->sendSMS($member->phone_number, $text);
            } catch (\Throwable $e) {
                Log::error('SMS sending failed: '.$e->getMessage());
            }
        }

        // Send Email
        if ($member->email) {
            try {
                Mail::to($member->email)->send(
                    new MemberAuthorizedMail($fullName, $membershipNumber)
                );
            } catch (\Throwable $e) {
                Log::error('Email sending failed: '.$e->getMessage());
            }
        }
    }
}
