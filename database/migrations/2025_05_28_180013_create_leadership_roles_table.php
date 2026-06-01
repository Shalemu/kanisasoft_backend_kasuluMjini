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
        Schema::create('leadership_roles', function (Blueprint $table) {
            $table->id();
            $table->string('title')->unique(); // e.g., Katibu, Mweka Hazina
            $table->boolean('requires_member')->default(true); // true if must be registered member
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('leadership_roles');
    }
};
