<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
 public function up(): void
{
    Schema::table('groups', function (Blueprint $table) {

        // ✅ Add leader_id ONLY if not exists
        if (!Schema::hasColumn('groups', 'leader_id')) {
            $table->foreignId('leader_id')
                  ->nullable()
                  ->after('name')
                  ->constrained('members')
                  ->nullOnDelete();
        }

        // ✅ Drop old columns ONLY if they exist
        if (Schema::hasColumn('groups', 'zone')) {
            $table->dropColumn('zone');
        }

        if (Schema::hasColumn('groups', 'leader')) {
            $table->dropColumn('leader');
        }

        if (Schema::hasColumn('groups', 'contact')) {
            $table->dropColumn('contact');
        }
    });
}


   public function down(): void
{
    Schema::table('groups', function (Blueprint $table) {

        if (!Schema::hasColumn('groups', 'zone')) {
            $table->string('zone')->nullable();
        }

        if (!Schema::hasColumn('groups', 'leader')) {
            $table->string('leader')->nullable();
        }

        if (!Schema::hasColumn('groups', 'contact')) {
            $table->string('contact')->nullable();
        }

        if (Schema::hasColumn('groups', 'leader_id')) {
            $table->dropForeign(['leader_id']);
            $table->dropColumn('leader_id');
        }
    });
}

};
