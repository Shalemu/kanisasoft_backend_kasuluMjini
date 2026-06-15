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
        Schema::create('rasilimali', function (Blueprint $table) {
            $table->id();
            $table->string('title');
            $table->text('description')->nullable();
            $table->string('link', 500)->nullable();
            $table->string('file_path', 500)->nullable();
            $table->string('file_type', 100)->nullable();
            $table->foreignId('uploaded_by_id')->nullable()->constrained('users');
            $table->string('uploaded_by_role', 100)->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('rasilimali');
    }
};
