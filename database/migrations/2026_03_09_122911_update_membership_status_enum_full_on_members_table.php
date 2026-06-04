<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        if (DB::getDriverName() !== 'sqlite') {
            // Temporarily change enum to string to allow updates.
            Schema::table('members', function (Blueprint $table) {
                $table->string('membership_status')->change();
            });
        }

        // Step 1: set any invalid statuses to 'pending'
        DB::table('members')
            ->whereNotIn('membership_status', ['pending', 'active', 'rejected', 'deactivated', 'left', 'detained', 'deceased', 'lost'])
            ->update(['membership_status' => 'pending']);

        // Step 2: convert column to new full ENUM
        Schema::table('members', function (Blueprint $table) {
            if (DB::getDriverName() !== 'sqlite') {
                $table->enum('membership_status', [
                    'pending',
                    'active',
                    'rejected',
                    'deactivated',
                    'left',
                    'detained',
                    'deceased',
                    'lost',
                ])
                    ->default('pending')
                    ->change();
            }

            // Make sure deactivation_reason exists
            if (! Schema::hasColumn('members', 'deactivation_reason')) {
                $table->string('deactivation_reason')->nullable()->after('membership_status');
            }
        });
    }

    public function down(): void
    {
        Schema::table('members', function (Blueprint $table) {
            if (DB::getDriverName() !== 'sqlite') {
                $table->enum('membership_status', ['pending', 'active', 'rejected', 'deactivated'])->default('pending')->change();
            }

            if (Schema::hasColumn('members', 'deactivation_reason')) {
                $table->dropColumn('deactivation_reason');
            }
        });
    }
};
