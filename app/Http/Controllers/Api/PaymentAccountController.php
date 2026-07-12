<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\PaymentAccount;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class PaymentAccountController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $accounts = PaymentAccount::orderBy('sort_order')
            ->latest()
            ->get();

        return response()->json([
            'success' => true,
            'data' => $accounts,
        ]);
    }

    /**
     * Store a newly created resource.
     */
    public function store(Request $request)
    {
        $validated = $request->validate([
            'name' => 'required|string|max:255',
            'account_name' => 'required|string|max:255',
            'account_number' => 'required|string|max:255',
            'type' => 'required|string',
            'logo' => 'nullable|image|mimes:jpg,jpeg,png,webp|max:2048',
            'instructions' => 'nullable|string',
            'sort_order' => 'nullable|integer',
            'is_active' => 'nullable|boolean',
        ]);

        if ($request->hasFile('logo')) {
            $validated['logo'] = $request->file('logo')
                ->store('payment_accounts', 'public');
        }

        $account = PaymentAccount::create($validated);

        return response()->json([
            'success' => true,
            'message' => 'Payment account created successfully.',
            'data' => $account,
        ], 201);
    }

    /**
     * Display the specified resource.
     */
    public function show(PaymentAccount $paymentAccount)
    {
        return response()->json([
            'success' => true,
            'data' => $paymentAccount,
        ]);
    }

    /**
     * Update the specified resource.
     */
    public function update(Request $request, PaymentAccount $paymentAccount)
    {
        $validated = $request->validate([
            'name' => 'required|string|max:255',
            'account_name' => 'required|string|max:255',
            'account_number' => 'required|string|max:255',
            'type' => 'required|string',
            'logo' => 'nullable|image|mimes:jpg,jpeg,png,webp|max:2048',
            'instructions' => 'nullable|string',
            'sort_order' => 'nullable|integer',
            'is_active' => 'nullable|boolean',
        ]);

        if ($request->hasFile('logo')) {

            if ($paymentAccount->logo) {
                Storage::disk('public')->delete($paymentAccount->logo);
            }

            $validated['logo'] = $request->file('logo')
                ->store('payment_accounts', 'public');
        }

        $paymentAccount->update($validated);

        return response()->json([
            'success' => true,
            'message' => 'Payment account updated successfully.',
            'data' => $paymentAccount,
        ]);
    }

    /**
     * Remove the specified resource.
     */
    public function destroy(PaymentAccount $paymentAccount)
    {
        if ($paymentAccount->logo) {
            Storage::disk('public')->delete($paymentAccount->logo);
        }

        $paymentAccount->delete();

        return response()->json([
            'success' => true,
            'message' => 'Payment account deleted successfully.',
        ]);
    }
}