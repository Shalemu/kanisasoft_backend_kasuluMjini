<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class UserSetting extends Model
{
    protected $fillable = ['user_id', 'key', 'value'];

    // Helper for easy access
    public static function getForUser($userId, $key, $default = null)
    {
        return static::where('user_id', $userId)->where('key', $key)->value('value') ?? $default;
    }

    public static function setForUser($userId, $key, $value)
    {
        return static::updateOrCreate(
            ['user_id' => $userId, 'key' => $key],
            ['value' => $value]
        );
    }

    public function saveVerse(Request $request)
{
    $user = $request->user();
    if (!$user) {
        return response()->json(['status' => 'error', 'message' => 'Una ruhusa. Tafadhali login tena.'], 401);
    }
    $request->validate(['verse' => 'required|string|max:255']);

    $setting = UserSetting::setForUser($user->id, 'dashboard_verse', $request->verse);

    return response()->json([
        'status' => 'success',
        'verse' => $setting->value,
        'message' => 'Verse saved!',
    ]);
}

}
