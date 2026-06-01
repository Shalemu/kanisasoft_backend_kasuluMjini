<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('service_events', function (Blueprint $table) {
            if (!Schema::hasColumn('service_events', 'preacher_description')) {
                $table->text('preacher_description')->nullable()->after('preacher');
            }
        });
    }

    public function down(): void
    {
        Schema::table('service_events', function (Blueprint $table) {
            if (Schema::hasColumn('service_events', 'preacher_description')) {
                $table->dropColumn('preacher_description');
            }
        });
    }
};