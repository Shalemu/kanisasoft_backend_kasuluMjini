<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Member;
use App\Models\MemberMarriage;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;

class MemberMarriageController extends Controller
{
    public function index()
    {
        return response()->json([
            'status' => 'success',
            'marriages' => MemberMarriage::with(['husband.user', 'wife.user'])
                ->latest()
                ->get(),
        ]);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'husband_id' => 'required|integer|exists:members,id|different:wife_id',
            'wife_id' => 'required|integer|exists:members,id|different:husband_id',
            'married_at' => 'nullable|date',
        ]);

        $husband = Member::findOrFail($validated['husband_id']);
        $wife = Member::findOrFail($validated['wife_id']);

        if ($husband->gender !== 'M' || $wife->gender !== 'F') {
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

            $marriage = MemberMarriage::create($validated);

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
}
