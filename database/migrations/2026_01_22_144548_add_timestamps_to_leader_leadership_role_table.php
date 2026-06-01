<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::table('leader_leadership_role', function (Blueprint $table) {
            if (!Schema::hasColumn('leader_leadership_role', 'created_at')) {
                $table->timestamps();
            }
        });

    }

    public function down(): void
    {
    Schema::table('leader_leadership_role', function (Blueprint $table) {
    if (Schema::hasColumn('leader_leadership_role', 'created_at')) {
        $table->dropTimestamps();
    }
});

    }
};
