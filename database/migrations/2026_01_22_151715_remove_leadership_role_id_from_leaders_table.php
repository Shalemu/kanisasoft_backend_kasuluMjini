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
    Schema::table('leaders', function (Blueprint $table) {
        // Drop foreign key first
        $table->dropForeign(['leadership_role_id']);

        // Now drop the column
        $table->dropColumn('leadership_role_id');
    });
}

public function down(): void
{
    Schema::table('leaders', function (Blueprint $table) {
        $table->unsignedBigInteger('leadership_role_id')->nullable();
        $table->foreign('leadership_role_id')
              ->references('id')
              ->on('leadership_roles')
              ->cascadeOnDelete();
    });
}


};
