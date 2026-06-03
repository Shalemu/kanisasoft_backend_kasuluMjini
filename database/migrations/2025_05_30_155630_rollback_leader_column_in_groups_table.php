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
    if (!Schema::hasTable('groups')) {
        return;
    }

    Schema::table('groups', function (Blueprint $table) {
        if (Schema::hasColumn('groups', 'leader_id')) {
            if (DB::getDriverName() !== 'sqlite') {
                $table->dropForeign(['leader_id']);
            }

            $table->dropColumn('leader_id');
        }

        if (!Schema::hasColumn('groups', 'leader')) {
            $table->string('leader')->nullable();
        }
    });
}

public function down(): void
{
    if (!Schema::hasTable('groups')) {
        return;
    }

    Schema::table('groups', function (Blueprint $table) {
        if (Schema::hasColumn('groups', 'leader')) {
            $table->dropColumn('leader');
        }

        if (!Schema::hasColumn('groups', 'leader_id')) {
            $table->unsignedBigInteger('leader_id')->nullable();
            $table->foreign('leader_id')->references('id')->on('members')->nullOnDelete();
        }
    });
}

};
