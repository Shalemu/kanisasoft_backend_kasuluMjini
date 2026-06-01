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
        Schema::create('assets', function (Blueprint $table) {
            $table->id();
            $table->string('name'); // Jina la mali
            $table->string('category'); // Aina ya mali (e.g. gari, jengo)
            $table->string('location')->nullable(); // Mahali ilipo
            $table->date('acquired_date')->nullable(); // Tarehe iliyonunuliwa
            $table->decimal('value', 12, 2)->nullable(); // Thamani ya mali
            $table->text('description')->nullable(); // Maelezo ya ziada
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('assets');
    }
};
