<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Group;
use App\Models\Member;
use Illuminate\Support\Facades\Validator;

class GroupsController extends Controller
{
    /**
     * Normalize membership number (1 -> 0001)
     */
    private function normalizeMembershipNumber(string|int $number): string
    {
        return str_pad((int) $number, 4, '0', STR_PAD_LEFT);
    }

    /**
     * List all groups with members count
     */
    public function index()
    {
        $groups = Group::with(['leader'])
            ->withCount('members')
            ->get();

        return response()->json([
            'status' => 'success',
            'groups' => $groups,
        ]);
    }

    /**
     * Get members of a group with their contact info (phone & email)
     */
    public function members($id)
    {
        $group = Group::find($id);

        if (!$group) {
            return response()->json([
                'status' => 'error',
                'message' => 'Group not found',
            ], 404);
        }

        $members = $group->members()->get()->map(function ($member) {
            return [
                'id' => $member->id,
                'full_name' => $member->full_name,
                'membership_number' => $member->membership_number,
                'phone_number' => $member->phone_number,
                'email' => $member->email,
                'gender' => $member->gender,
                'residential_zone' => $member->residential_zone,
            ];
        });

        return response()->json([
            'status' => 'success',
            'group' => [
                'id' => $group->id,
                'name' => $group->name,
                'members_count' => $members->count(),
            ],
            'members' => $members,
        ]);
    }

    /**
     * Show a single group
     */
    public function show($id)
    {
        $group = Group::with(['leader', 'members'])->find($id);

        if (!$group) {
            return response()->json([
                'status' => 'error',
                'message' => 'Group not found',
            ], 404);
        }

        return response()->json([
            'status' => 'success',
            'group' => $group,
        ]);
    }

    /**
     * Create a new group
     */
/**
 * Create a new group
 */
public function store(Request $request)
{
    // Validate input
    $validator = Validator::make($request->all(), [
        'name' => 'required|string|max:255',
        'leader_membership_number' => 'nullable|string',
        'whatsapp_link' => 'nullable|url',
    ]);

    if ($validator->fails()) {
        return response()->json([
            'status' => 'error',
            'errors' => $validator->errors(),
        ], 422);
    }

    // Check if a group with the same name exists (ignore deleted groups)
    $existing = Group::where('name', $request->name)->first();
    if ($existing) {
        return response()->json([
            'status' => 'error',
            'message' => 'Jina la kundi tayari limepatikana.',
        ], 409);
    }

    $leaderId = null;

    // Verify leader membership number if provided
    if ($request->filled('leader_membership_number')) {
        $normalized = $this->normalizeMembershipNumber($request->leader_membership_number);
        $member = Member::where('membership_number', $normalized)->first();

        if (!$member) {
            return response()->json([
                'status' => 'error',
                'message' => 'Huyo mshirika hana namba ya ushirika.',
            ], 404);
        }

        $leaderId = $member->id;
    }

    $group = Group::create([
        'name' => $request->name,
        'leader_id' => $leaderId,
        'whatsapp_link' => $request->whatsapp_link,
    ]);

    return response()->json([
        'status' => 'success',
        'message' => 'Kundi limeundwa kikamilifu.',
        'group' => $group->load('leader'),
    ], 201);
}

/**
 * Update group
 */
public function update(Request $request, $id)
{
    $group = Group::find($id);

    if (!$group) {
        return response()->json([
            'status' => 'error',
            'message' => 'Kundi halikupatikana.',
        ], 404);
    }

    // Validate input
    $validator = Validator::make($request->all(), [
        'name' => 'sometimes|required|string|max:255',
        'leader_membership_number' => 'nullable|string',
        'whatsapp_link' => 'nullable|url', // ✅ WhatsApp link is nullable
    ]);

    if ($validator->fails()) {
        return response()->json([
            'status' => 'error',
            'errors' => $validator->errors(),
        ], 422);
    }

    // Update name if provided
    if ($request->filled('name')) {
        $exists = Group::where('name', $request->name)
            ->where('id', '!=', $group->id)
            ->first();

        if ($exists) {
            return response()->json([
                'status' => 'error',
                'message' => 'Jina la kundi tayari limepatikana.',
            ], 409);
        }

        $group->name = $request->name;
    }

    // Update leader if provided
    if ($request->has('leader_membership_number')) {
        if (!$request->leader_membership_number) {
            $group->leader_id = null;
        } else {
            $normalized = $this->normalizeMembershipNumber($request->leader_membership_number);
            $member = Member::where('membership_number', $normalized)->first();

            if (!$member) {
                return response()->json([
                    'status' => 'error',
                    'message' => 'Huyo mshirika hana namba ya ushirika.',
                ], 404);
            }

            $group->leader_id = $member->id;
        }
    }

    //  Update or set WhatsApp link
    if ($request->has('whatsapp_link')) {
        $group->whatsapp_link = $request->whatsapp_link; // can be null if empty
    }

    $group->save();

    return response()->json([
        'status' => 'success',
        'message' => 'Kundi limehaririwa kikamilifu.',
        'group' => $group->load('leader'),
    ]);
}


    /**
     * Delete group
     */
    public function destroy($id)
    {
        $group = Group::find($id);

        if (!$group) {
            return response()->json([
                'status' => 'error',
                'message' => 'Group not found',
            ], 404);
        }

        $group->delete();

        return response()->json([
            'status' => 'success',
            'message' => 'Kundi limefutwa kikamilifu.',
        ]);
    }

    /**
     * Add member to group by membership number
     */
public function addMember(Request $request, Group $group)
{
    $request->validate([
        'membership_number' => 'required',
    ]);

    $normalized = $this->normalizeMembershipNumber($request->membership_number);

    $member = Member::where('membership_number', $normalized)->first();
    if (!$member) {
        return response()->json([
            'status' => 'error',
            'message' => 'Mshirika mwenye namba hiyo hajapatikana.',
        ], 404);
    }

    $user = $request->user();


    if (!$user->hasSystemRole('admin')) {

       
        if (!$user->member || $user->member->id !== $group->leader_id) {
            return response()->json([
                'status' => 'error',
                'message' => 'Huna ruhusa ya kuongeza washirika kwenye kundi hili.',
            ], 403);
        }
    }

    // 🚫 Already exists
    if ($group->members()->where('member_id', $member->id)->exists()) {
        return response()->json([
            'status' => 'error',
            'message' => 'Mshirika tayari yupo kwenye kundi hili.',
        ], 409);
    }

    $group->members()->attach($member->id);

    return response()->json([
        'status' => 'success',
        'message' => 'Mshirika ameongezwa kwenye kundi.',
        'member' => [
            'full_name' => $member->full_name,
            'membership_number' => $member->membership_number,
        ],
        'group' => [
            'id' => $group->id,
            'name' => $group->name,
        ],
    ]);
}


    /**
     * Remove member from group
     */
    public function removeMember(Request $request, Group $group)
    {
        $request->validate([
            'membership_number' => 'required',
        ]);

        $normalized = $this->normalizeMembershipNumber($request->membership_number);
        $member = Member::where('membership_number', $normalized)->first();

        if (!$member) {
            return response()->json([
                'status' => 'error',
                'message' => 'Mshirika hajapatikana.',
            ], 404);
        }

        if ($request->user()->member->id !== $group->leader_id) {
            return response()->json([
                'status' => 'error',
                'message' => 'Huna ruhusa ya kuondoa washirika kwenye kundi hili.',
            ], 403);
        }

        $group->members()->detach($member->id);

        return response()->json([
            'status' => 'success',
            'message' => 'Mshirika ameondolewa kwenye kundi.',
        ]);
    }

    /**
     * Assign or remove group leader using membership number
     */
    public function assignLeader(Request $request, Group $group)
    {
        if (!$request->membership_number) {
            $group->leader_id = null;
            $group->save();

            return response()->json([ 
                'status' => 'success',
                'message' => 'Kiongozi wa kundi ameondolewa.',
            ]);
        }

        $normalized = $this->normalizeMembershipNumber($request->membership_number);
        $member = Member::where('membership_number', $normalized)->first();

        if (!$member) {
            return response()->json([
                'status' => 'error',
                'message' => 'Namba ya ushirika haipo.',
            ], 404);
        }

        $group->leader_id = $member->id;
        $group->save();

        return response()->json([
            'status' => 'success',
            'message' => 'Kiongozi wa kundi amewekwa kikamilifu.',
            'leader' => [
                'full_name' => $member->full_name,
                'membership_number' => $member->membership_number,
            ],
        ]);
    }

  public function members($id)
{
    // Load group with members and leader
    $group = Group::with(['members.user', 'leader'])->find($id);

    if (!$group) {
        return response()->json([
            'status' => 'error',
            'message' => 'Kundi halikupatikana.',
        ], 404);
    }

    // Prepare members data
    $members = $group->members->map(function ($member) {
        return [
            'id' => $member->id,
            'full_name' => $member->full_name,
            'email' => $member->email,
            'role' => $member->user?->role ?? null,
            'membership_number' => $member->membership_number ?? null,
            'photo_url' => $member->photo_url ?? null,
        ];
    });

    // Leader info (separate object)
    $leader = $group->leader ? [
        'id' => $group->leader->id,
        'full_name' => $group->leader->full_name,
        'email' => $group->leader->email ?? null,
        'role' => $group->leader->user?->role ?? null,
        'membership_number' => $group->leader->membership_number ?? null,
        'photo_url' => $group->leader->photo_url ?? null,
    ] : null;

    return response()->json([
        'status' => 'success',
        'members' => $members,
        'leader_id' => $group->leader_id,
        'leader' => $leader,
    ]);
}
    /**
     * Search members in group
     */
    public function searchGroupMembers($id, Request $request)
    {
        $keyword = strtolower($request->query('search'));
        $group = Group::with(['members.user'])->findOrFail($id);

        $filtered = $group->members->filter(fn ($m) =>
            str_contains(strtolower($m->full_name), $keyword) ||
            str_contains($m->membership_number, $keyword) ||
            str_contains(strtolower($m->user?->role ?? ''), $keyword)
        )->values();

        return response()->json([
            'status' => 'success',
            'members' => $filtered,
        ]);
    }
}
