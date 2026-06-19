<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('service_events', function (Blueprint $table) {
            if (!Schema::hasColumn('service_events', 'duty_leader')) {
                $table->string('duty_leader')->nullable();
            }
        });
    }

    public function down(): void
    {
        Schema::table('service_events', function (Blueprint $table) {
            if (Schema::hasColumn('service_events', 'duty_leader')) {
                $table->dropColumn('duty_leader');
            }
        });
    }
};
