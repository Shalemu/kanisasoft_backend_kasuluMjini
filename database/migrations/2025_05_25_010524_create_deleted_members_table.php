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
        Schema::create('deleted_members', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('user_id')->nullable(); // Related user, optional
            $table->string('full_name');
            $table->string('email')->nullable();
            $table->string('phone')->nullable();
            $table->string('gender')->nullable();
            $table->date('birth_date')->nullable();
            $table->string('reason')->nullable(); // Reason for deletion
            $table->string('deleted_by')->nullable(); // Admin name or ID who deleted
            $table->timestamp('deleted_at'); // Date of deletion
            $table->timestamps(); // created_at, updated_at (for backup history)
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('deleted_members');
    }
};
