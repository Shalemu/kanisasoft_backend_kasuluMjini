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
        Schema::create('member_group', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('member_id');
            $table->unsignedBigInteger('group_id');
            $table->timestamps();

            // Foreign Keys
            $table->foreign('member_id')->references('id')->on('members')->onDelete('cascade');
            $table->foreign('group_id')->references('id')->on('groups')->onDelete('cascade');

            // Prevent duplicate combinations
            $table->unique(['member_id', 'group_id']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('member_group');
    }
};
