<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
   public function up(): void
{
    Schema::table('members', function (Blueprint $table) {
        if (DB::getDriverName() !== 'sqlite') {
            // Change membership_status to enum: pending, active, rejected
            $table->enum('membership_status', ['pending', 'active', 'rejected'])
                  ->default('pending')
                  ->change();
        }

        // Add deactivation_reason to store why member left/rejected etc.
        if (!Schema::hasColumn('members', 'deactivation_reason')) {
    $table->string('deactivation_reason')->nullable()->after('membership_status');
}

        
        // $table->string('deactivation_reason')->nullable()->after('membership_status');
    });
}

public function down(): void
{
    Schema::table('members', function (Blueprint $table) {
        if (DB::getDriverName() !== 'sqlite') {
            // revert back if needed
            $table->enum('membership_status', ['active', 'left', 'detained', 'deceased', 'lost'])
                  ->default('active')
                  ->change();
        }

        if (Schema::hasColumn('members', 'deactivation_reason')) {
            $table->dropColumn('deactivation_reason');
        }
    });
}
};
