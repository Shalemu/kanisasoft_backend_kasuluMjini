<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        if (!Schema::hasTable('groups')) {
            return;
        }

        Schema::table('groups', function (Blueprint $table) {
            if (Schema::hasColumn('groups', 'leader')) {
                $table->dropColumn('leader');
            }

            if (!Schema::hasColumn('groups', 'leader_id')) {
                $table->unsignedBigInteger('leader_id')->nullable()->after('zone');

                $table->foreign('leader_id')
                    ->references('id')
                    ->on('members')
                    ->nullOnDelete();
            }
        });
    }

    public function down(): void
    {
        if (!Schema::hasTable('groups')) {
            return;
        }

        Schema::table('groups', function (Blueprint $table) {
            $table->dropForeign(['leader_id']);
            $table->dropColumn('leader_id');
            $table->string('leader')->nullable();
        });
    }
};

