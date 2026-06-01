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
        Schema::table('groups', function (Blueprint $table) {
            if (!Schema::hasColumn('groups', 'whatsapp_link')) {
                $table->string('whatsapp_link')->nullable()->after('leader_id');
            }
        });
    }

    public function down(): void
    {
        Schema::table('groups', function (Blueprint $table) {
            if (Schema::hasColumn('groups', 'whatsapp_link')) {
                $table->dropColumn('whatsapp_link');
            }
        });
    }
};