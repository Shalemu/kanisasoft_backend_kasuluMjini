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
    if (
        DB::getDriverName() === 'sqlite'
        || !Schema::hasTable('leaders')
        || !Schema::hasColumn('leaders', 'leadership_role_id')
    ) {
        return;
    }

    Schema::table('leaders', function (Blueprint $table) {
        // Drop foreign key first
        $table->dropForeign(['leadership_role_id']);

        // Now drop the column
        $table->dropColumn('leadership_role_id');
    });
}

public function down(): void
{
    if (!Schema::hasTable('leaders') || Schema::hasColumn('leaders', 'leadership_role_id')) {
        return;
    }

    Schema::table('leaders', function (Blueprint $table) {
        $table->unsignedBigInteger('leadership_role_id')->nullable();
        $table->foreign('leadership_role_id')
              ->references('id')
              ->on('leadership_roles')
              ->cascadeOnDelete();
    });
}


};
