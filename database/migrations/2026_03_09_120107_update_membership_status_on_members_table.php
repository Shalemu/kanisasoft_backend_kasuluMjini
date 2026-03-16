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
    Schema::table('members', function (Blueprint $table) {
        // Change membership_status to enum: pending, active, rejected
        $table->enum('membership_status', ['pending', 'active', 'rejected'])
              ->default('pending')
              ->change();

        // Add deactivation_reason to store why member left/rejected etc.
        $table->string('deactivation_reason')->nullable()->after('membership_status');
    });
}

public function down(): void
{
    Schema::table('members', function (Blueprint $table) {
        // revert back if needed
        $table->enum('membership_status', ['active', 'left', 'detained', 'deceased', 'lost'])
              ->default('active')
              ->change();

        $table->dropColumn('deactivation_reason');
    });
}
};
