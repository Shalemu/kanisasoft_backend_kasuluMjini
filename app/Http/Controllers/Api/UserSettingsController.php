<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\SupportRequest;
use App\Models\UserSetting;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Validation\Rule;

class UserSettingsController extends Controller
{
    private const ACCOUNT_SETTINGS_KEY = 'account_settings';

    private function defaultAccountSettings(): array
    {
        return [
            'appearance' => [
                'theme' => 'system',
                'compact_mode' => false,
                'sidebar_collapsed' => false,
            ],
            'localization' => [
                'language' => 'sw',
                'timezone' => 'Africa/Dar_es_Salaam',
                'date_format' => 'd/m/Y',
                'time_format' => '24h',
            ],
            'notifications' => [
                'email_notifications' => true,
                'sms_notifications' => false,
                'whatsapp_notifications' => false,
                'member_registration_alerts' => true,
                'contribution_alerts' => true,
                'event_reminders' => true,
                'support_updates' => true,
            ],
            'dashboard' => [
                'default_date_range' => 'month',
                'records_per_page' => 25,
                'auto_refresh' => false,
                'show_dashboard_verse' => true,
            ],
            'privacy' => [
                'show_phone_to_leaders' => true,
                'show_email_to_leaders' => false,
                'login_alerts' => true,
            ],
            'support' => [
                'preferred_contact_method' => 'email',
            ],
        ];
    }

    private function getAccountSettingsForUser(int $userId): array
    {
        $stored = UserSetting::getForUser($userId, self::ACCOUNT_SETTINGS_KEY, null);
        $decoded = is_string($stored) ? json_decode($stored, true) : null;

        return array_replace_recursive($this->defaultAccountSettings(), is_array($decoded) ? $decoded : []);
    }

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

    public function profile(Request $request)
    {
        $user = $request->user()->fresh();

        return response()->json([
            'status' => 'success',
            'profile' => [
                'id' => $user->id,
                'full_name' => $user->full_name,
                'email' => $user->email,
                'phone' => $user->phone,
                'role' => $user->role,
                'profile_picture_url' => $user->profile_picture_url,
                'profile_picture_path' => $user->profile_picture_path,
            ],
        ]);
    }

    public function updateProfile(Request $request)
    {
        $user = $request->user();

        $validated = $request->validate([
            'full_name' => ['required', 'string', 'max:255'],
            'profile_picture' => ['nullable', 'image', 'mimes:jpg,jpeg,png,webp', 'max:2048'],
        ]);

        $updates = [
            'full_name' => $validated['full_name'],
        ];

        if ($request->hasFile('profile_picture')) {
            if ($user->profile_picture_path && Storage::disk('public')->exists($user->profile_picture_path)) {
                Storage::disk('public')->delete($user->profile_picture_path);
            }

            $updates['profile_picture_path'] = $request->file('profile_picture')->store('profile-pictures', 'public');
        }

        $user->update($updates);

        return response()->json([
            'status' => 'success',
            'message' => 'Profile updated successfully.',
            'profile' => [
                'id' => $user->id,
                'full_name' => $user->fresh()->full_name,
                'email' => $user->email,
                'phone' => $user->phone,
                'role' => $user->role,
                'profile_picture_url' => $user->fresh()->profile_picture_url,
                'profile_picture_path' => $user->fresh()->profile_picture_path,
            ],
        ]);
    }

    public function getAccountSettings(Request $request)
    {
        return response()->json([
            'status' => 'success',
            'settings' => $this->getAccountSettingsForUser($request->user()->id),
        ]);
    }

    public function updateAccountSettings(Request $request)
    {
        $validated = $request->validate([
            'appearance' => ['sometimes', 'array'],
            'appearance.theme' => ['sometimes', Rule::in(['light', 'dark', 'system'])],
            'appearance.compact_mode' => ['sometimes', 'boolean'],
            'appearance.sidebar_collapsed' => ['sometimes', 'boolean'],

            'localization' => ['sometimes', 'array'],
            'localization.language' => ['sometimes', Rule::in(['sw', 'en'])],
            'localization.timezone' => ['sometimes', 'string', 'timezone'],
            'localization.date_format' => ['sometimes', Rule::in(['d/m/Y', 'Y-m-d', 'm/d/Y'])],
            'localization.time_format' => ['sometimes', Rule::in(['12h', '24h'])],

            'notifications' => ['sometimes', 'array'],
            'notifications.email_notifications' => ['sometimes', 'boolean'],
            'notifications.sms_notifications' => ['sometimes', 'boolean'],
            'notifications.whatsapp_notifications' => ['sometimes', 'boolean'],
            'notifications.member_registration_alerts' => ['sometimes', 'boolean'],
            'notifications.contribution_alerts' => ['sometimes', 'boolean'],
            'notifications.event_reminders' => ['sometimes', 'boolean'],
            'notifications.support_updates' => ['sometimes', 'boolean'],

            'dashboard' => ['sometimes', 'array'],
            'dashboard.default_date_range' => ['sometimes', Rule::in(['today', 'week', 'month', 'quarter', 'year'])],
            'dashboard.records_per_page' => ['sometimes', 'integer', 'min:10', 'max:100'],
            'dashboard.auto_refresh' => ['sometimes', 'boolean'],
            'dashboard.show_dashboard_verse' => ['sometimes', 'boolean'],

            'privacy' => ['sometimes', 'array'],
            'privacy.show_phone_to_leaders' => ['sometimes', 'boolean'],
            'privacy.show_email_to_leaders' => ['sometimes', 'boolean'],
            'privacy.login_alerts' => ['sometimes', 'boolean'],

            'support' => ['sometimes', 'array'],
            'support.preferred_contact_method' => ['sometimes', Rule::in(['email', 'phone', 'whatsapp'])],
        ]);

        $settings = array_replace_recursive(
            $this->getAccountSettingsForUser($request->user()->id),
            $validated
        );

        UserSetting::setForUser(
            $request->user()->id,
            self::ACCOUNT_SETTINGS_KEY,
            json_encode($settings)
        );

        return response()->json([
            'status' => 'success',
            'message' => 'Account settings saved successfully.',
            'settings' => $settings,
        ]);
    }

    public function support(Request $request)
    {
        $user = $request->user();

        return response()->json([
            'status' => 'success',
            'support' => [
                'channels' => [
                    [
                        'type' => 'phone',
                        'label' => 'Namba ya Kupiga',
                        'value' => '0760 900 500',
                    ],
                    [
                        'type' => 'whatsapp',
                        'label' => 'WhatsApp',
                        'value' => '0760 900 500',
                    ],
                    [
                        'type' => 'email',
                        'label' => 'Email',
                        'value' => 'support@kanisasoft.co.tz',
                    ],
                ],
                'departments' => ['billing', 'support'],
                'user_info' => [
                    'name'   => $user->full_name,
                    'phone'  => $user->phone,
                    'email'  => $user->email,
                    'church' => $user->church_name ?? $user->member?->church_name ?? 'Kanisa',
                ],
                'recent_requests' => SupportRequest::where('user_id', $user->id)
                    ->latest()
                    ->limit(10)
                    ->get(),
            ],
        ]);
    }

    public function createSupportRequest(Request $request)
    {
        $user = $request->user();

        $validated = $request->validate([
            'department' => ['required', 'string', 'in:billing,support'],
            'message'    => ['required', 'string', 'max:5000'],
            'name'       => ['nullable', 'string', 'max:255'],
            'phone'      => ['nullable', 'string', 'max:30'],
            'email'      => ['nullable', 'email', 'max:255'],
            'church'     => ['nullable', 'string', 'max:255'],
        ]);

        // Auto-fill from user account
        $name   = $validated['name']   ?? $user->full_name;
        $phone  = $validated['phone']  ?? $user->phone;
        $email  = $validated['email']  ?? $user->email;
        $church = $validated['church'] ?? $user->church_name ?? $user->member?->church_name ?? 'Kanisa';

        $supportRequest = SupportRequest::create([
            'user_id'        => $user->id,
            'department'      => $validated['department'],
            'name'            => $name,
            'phone'           => $phone,
            'email'           => $email,
            'church'          => $church,
            'subject'          => ucfirst($validated['department']) . ' support',
            'message'         => $validated['message'],
            'contact_email'   => $email,
            'contact_phone'   => $phone,
            'category'        => $validated['department'],
            'status'          => 'open',
        ]);

        return response()->json([
            'status' => 'success',
            'message' => 'Ujumbe wako umetumwa kwa KanisaSoft.',
            'data' => $supportRequest,
        ], 201);
    }

    public function supportRequests(Request $request)
    {
        return response()->json([
            'status' => 'success',
            'support_requests' => SupportRequest::where('user_id', $request->user()->id)
                ->latest()
                ->paginate(min(max((int) $request->input('per_page', 15), 1), 100)),
        ]);
    }
}
