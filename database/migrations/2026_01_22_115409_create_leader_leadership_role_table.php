<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('leader_leadership_role', function (Blueprint $table) {
            $table->id();

            $table->foreignId('leader_id')
                ->constrained('leaders')
                ->cascadeOnDelete();

            $table->foreignId('leadership_role_id')
                ->constrained('leadership_roles')
                ->cascadeOnDelete();

            // prevent duplicate role assignment
            $table->unique(['leader_id', 'leadership_role_id']);

            // Timestamps to track when a role was assigned
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('leader_leadership_role');
    }
};
