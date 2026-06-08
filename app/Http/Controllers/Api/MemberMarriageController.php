<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Member;
use App\Models\MemberMarriage;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;
use Illuminate\Validation\ValidationException;

class MemberMarriageController extends Controller
{
    public function index()
    {
        if (! Schema::hasTable('member_marriages')) {
            return $this->inferredMarriagesResponse();
        }

        $marriages = MemberMarriage::with(['husband.user', 'wife.user'])
            ->latest()
            ->get();

        if ($marriages->isEmpty()) {
            return $this->inferredMarriagesResponse();
        }

        return response()->json([
            'status' => 'success',
            'source' => 'member_marriages',
            'summary' => [
                'total_marriages' => $marriages->count(),
                'linked_marriages' => $marriages->count(),
                'inferred_marriages' => 0,
            ],
            'marriages' => $marriages,
        ]);
    }

    public function options()
    {
        $members = Member::query()
            ->select('id', 'user_id', 'full_name', 'gender', 'membership_number', 'marital_status', 'spouse_name')
            ->with([
                'marriageAsHusband:id,husband_id,wife_id,married_at',
                'marriageAsWife:id,husband_id,wife_id,married_at',
            ])
            ->orderBy('full_name')
            ->get()
            ->map(fn (Member $member) => [
                'id' => $member->id,
                'member_id' => $member->id,
                'user_id' => $member->user_id,
                'full_name' => $member->full_name,
                'gender' => $this->normalizedGender($member),
                'membership_number' => $member->membership_number,
                'marital_status' => $member->marital_status,
                'spouse_name' => $member->spouse_name,
                'marriage_id' => $member->marriageAsHusband?->id ?? $member->marriageAsWife?->id,
                'married_at' => $member->marriageAsHusband?->married_at ?? $member->marriageAsWife?->married_at,
            ]);

        return response()->json([
            'status' => 'success',
            'husbands' => $members->filter(fn (array $member) => $member['gender'] === 'M')->values(),
            'wives' => $members->filter(fn (array $member) => $member['gender'] === 'F')->values(),
        ]);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'husband_id' => 'required_without:husband_member_id|integer|different:wife_id',
            'wife_id' => 'required_without:wife_member_id|integer|different:husband_id',
            'husband_member_id' => 'nullable|integer|different:wife_member_id',
            'wife_member_id' => 'nullable|integer|different:husband_member_id',
            'married_at' => 'nullable|date',
        ]);

        $husband = $this->resolveMember(
            $validated['husband_member_id'] ?? $validated['husband_id'] ?? null,
            'husband_id'
        );
        $wife = $this->resolveMember(
            $validated['wife_member_id'] ?? $validated['wife_id'] ?? null,
            'wife_id'
        );

        if ($husband->id === $wife->id) {
            throw ValidationException::withMessages([
                'wife_id' => ['The wife must be a different member from the husband.'],
            ]);
        }

        if (! $this->isMaleMember($husband) || ! $this->isFemaleMember($wife)) {
            throw ValidationException::withMessages([
                'husband_id' => ['The husband must be a male member and the wife must be a female member.'],
            ]);
        }

        $marriage = DB::transaction(function () use ($validated, $husband, $wife) {
            $existingMarriages = MemberMarriage::with(['husband.user', 'wife.user'])
                ->whereIn('husband_id', [$husband->id, $wife->id])
                ->orWhereIn('wife_id', [$husband->id, $wife->id])
                ->get();

            foreach ($existingMarriages as $existingMarriage) {
                $this->unlinkMembers($existingMarriage);
                $existingMarriage->delete();
            }

            $marriage = MemberMarriage::create([
                'husband_id' => $husband->id,
                'wife_id' => $wife->id,
                'married_at' => $validated['married_at'] ?? null,
            ]);

            $this->syncMember($husband, 'Ameoa', $wife->full_name);
            $this->syncMember($wife, 'Ameolewa', $husband->full_name);

            return $marriage;
        });

        return response()->json([
            'status' => 'success',
            'message' => 'Member marriage linked successfully.',
            'marriage' => $marriage->load(['husband.user', 'wife.user']),
        ], 201);
    }

    public function destroy(MemberMarriage $memberMarriage)
    {
        DB::transaction(function () use ($memberMarriage) {
            $this->unlinkMembers($memberMarriage->load(['husband.user', 'wife.user']));
            $memberMarriage->delete();
        });

        return response()->json([
            'status' => 'success',
            'message' => 'Member marriage link removed successfully.',
        ]);
    }

    private function unlinkMembers(MemberMarriage $marriage): void
    {
        $this->syncMember($marriage->husband, 'Hajaoa', null);
        $this->syncMember($marriage->wife, 'Hajaolewa', null);
    }

    private function syncMember(Member $member, string $maritalStatus, ?string $spouseName): void
    {
        $member->update([
            'marital_status' => $maritalStatus,
            'spouse_name' => $spouseName,
        ]);
    }

    private function resolveMember(?int $id, string $field): Member
    {
        if ($id === null) {
            throw ValidationException::withMessages([
                $field => ['Please select a member.'],
            ]);
        }

        $member = Member::find($id) ?? Member::where('user_id', $id)->first();

        if (! $member) {
            throw ValidationException::withMessages([
                $field => ['The selected member is invalid. Select a church member, not a free-text spouse name.'],
            ]);
        }

        return $member;
    }

    private function isMaleMember(Member $member): bool
    {
        return $this->normalizedGender($member) === 'M';
    }

    private function isFemaleMember(Member $member): bool
    {
        return $this->normalizedGender($member) === 'F';
    }

    private function normalizedGender(Member $member): ?string
    {
        return match ($member->gender) {
            'M', 'Mwanaume' => 'M',
            'F', 'Mwanamke' => 'F',
            default => null,
        };
    }

    private function inferredMarriagesResponse()
    {
        $members = Member::query()
            ->whereNotNull('spouse_name')
            ->where('spouse_name', '!=', '')
            ->orderBy('full_name')
            ->get();

        return response()->json([
            'status' => 'success',
            'source' => 'spouse_name',
            'summary' => [
                'total_marriages' => $members->count(),
                'linked_marriages' => 0,
                'inferred_marriages' => $members->count(),
            ],
            'marriages' => $members->map(fn (Member $member) => [
                'id' => 'inferred-'.$member->id,
                'husband_id' => $this->isMaleMember($member) ? $member->id : null,
                'wife_id' => $this->isFemaleMember($member) ? $member->id : null,
                'married_at' => null,
                'is_inferred' => true,
                'husband' => $this->isMaleMember($member) ? $member : null,
                'wife' => $this->isFemaleMember($member) ? $member : null,
                'spouse_name' => $member->spouse_name,
                'member' => $member,
            ])->values(),
        ]);
    }
}
