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
        if (!Schema::hasTable('groups') || Schema::hasColumn('groups', 'leader_id')) {
            return;
        }

        Schema::table('groups', function (Blueprint $table) {
            $table->unsignedBigInteger('leader_id')->nullable()->after('zone');
            $table->foreign('leader_id')->references('id')->on('members')->nullOnDelete();
        });
    }
    
    public function down(): void
    {
        if (!Schema::hasTable('groups') || !Schema::hasColumn('groups', 'leader_id')) {
            return;
        }

        Schema::table('groups', function (Blueprint $table) {
            if (DB::getDriverName() !== 'sqlite') {
                $table->dropForeign(['leader_id']);
            }

            $table->dropColumn('leader_id');
        });
    }
    
};
