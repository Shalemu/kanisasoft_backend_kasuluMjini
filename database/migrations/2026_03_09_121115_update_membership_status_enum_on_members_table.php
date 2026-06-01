<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        // Step 0: temporarily change column to string to allow updates
        Schema::table('members', function (Blueprint $table) {
            $table->string('membership_status')->change();
        });

        // Step 1: set invalid values to 'pending'
        DB::table('members')
            ->whereNotIn('membership_status', ['pending', 'active', 'rejected'])
            ->update(['membership_status' => 'pending']);

        // Step 2: convert column to new ENUM
        Schema::table('members', function (Blueprint $table) {
            $table->enum('membership_status', ['pending', 'active', 'rejected'])
                  ->default('pending')
                  ->change();
        });
    }

    public function down(): void
    {
        // Revert to old ENUM values if rolling back
        Schema::table('members', function (Blueprint $table) {
            $table->enum('membership_status', ['active', 'left', 'detained', 'deceased', 'lost'])
                  ->default('active')
                  ->change();
        });
    }
};