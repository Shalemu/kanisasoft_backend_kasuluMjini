<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        // First, make sure existing membership_status values are valid
        DB::table('members')->whereNotIn('membership_status', ['pending', 'active', 'rejected', 'deactivated'])
            ->update(['membership_status' => 'pending']);

        // Then, add the new enum values and the deactivation_reason column
        Schema::table('members', function (Blueprint $table) {
            $table->enum('membership_status', ['pending', 'active', 'rejected', 'deactivated'])
                  ->default('pending')
                  ->change();

            $table->string('deactivation_reason')->nullable()->after('membership_status');
        });
    }

    public function down(): void
    {
        Schema::table('members', function (Blueprint $table) {
            // Rollback enum to old values
            $table->enum('membership_status', ['active', 'left', 'detained', 'deceased', 'lost'])
                  ->default('active')
                  ->change();

            $table->dropColumn('deactivation_reason');
        });
    }
};