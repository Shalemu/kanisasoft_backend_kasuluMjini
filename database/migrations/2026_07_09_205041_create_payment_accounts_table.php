<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('payment_accounts', function (Blueprint $table) {
            $table->id();

            // Account Details
            $table->string('name'); // CRDB Bank, NMB Bank, M-Pesa...
            $table->string('account_name');
            $table->string('account_number');

            // Type
            $table->enum('type', [
                'bank',
                'mpesa',
                'airtel_money',
                'tigopesa',
                'halopesa',
                'mixx',
                'other'
            ])->default('bank');

            // Optional logo
            $table->string('logo')->nullable();

            // Payment instructions
            $table->text('instructions')->nullable();

            // Display order
            $table->integer('sort_order')->default(0);

            // Active / Inactive
            $table->boolean('is_active')->default(true);

            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('payment_accounts');
    }
};