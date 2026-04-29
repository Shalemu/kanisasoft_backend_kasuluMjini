<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('service_events', function (Blueprint $table) {
            $table->string('service_name')->nullable()->after('title');
            $table->string('preacher')->nullable()->after('description');
            $table->string('preacher_description')->nullable()->after('preacher');
            $table->text('message')->nullable()->after('preacher_description');
            $table->unsignedInteger('attendance_children')->default(0)->after('message');
            $table->unsignedInteger('attendance_women')->default(0)->after('attendance_children');
            $table->unsignedInteger('attendance_men')->default(0)->after('attendance_women');
            $table->unsignedInteger('total_attendance')->default(0)->after('attendance_men');
            $table->decimal('total_offerings', 12, 2)->default(0)->after('total_attendance');
            $table->string('leaders_on_duty')->nullable()->after('total_offerings');
        });
    }

    public function down(): void
    {
        Schema::table('service_events', function (Blueprint $table) {
            $table->dropColumn([
                'service_name', 'preacher', 'preacher_description', 'message',
                'attendance_children', 'attendance_women', 'attendance_men',
                'total_attendance', 'total_offerings', 'leaders_on_duty',
            ]);
        });
    }
};
