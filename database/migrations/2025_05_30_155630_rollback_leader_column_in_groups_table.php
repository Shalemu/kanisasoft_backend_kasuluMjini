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
    Schema::table('groups', function (Blueprint $table) {
        $table->dropForeign(['leader_id']);
        $table->dropColumn('leader_id');

        $table->string('leader')->nullable(); // optional: restore old column
    });
}

public function down(): void
{
    Schema::table('groups', function (Blueprint $table) {
        $table->dropColumn('leader');

        $table->unsignedBigInteger('leader_id')->nullable();
        $table->foreign('leader_id')->references('id')->on('members')->nullOnDelete();
    });
}

};
