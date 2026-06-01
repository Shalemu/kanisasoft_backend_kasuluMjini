<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\UserSetting;

class UserSettingsController extends Controller
{
    public function getVerse(Request $request)
    {
        $user = $request->user();
        $verse = UserSetting::getForUser($user->id, 'dashboard_verse', '');
        return response()->json([
            'status' => 'success',
            'verse' => $verse,
        ]);
    }

    public function saveVerse(Request $request)
    {
        $request->validate(['verse' => 'required|string|max:255']);
        $user = $request->user();

        $setting = UserSetting::setForUser($user->id, 'dashboard_verse', $request->verse);

        return response()->json([
            'status' => 'success',
            'verse' => $setting->value,
            'message' => 'Verse saved!',
        ]);
    }
}
