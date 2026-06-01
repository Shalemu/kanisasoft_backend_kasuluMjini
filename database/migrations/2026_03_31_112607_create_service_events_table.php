<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        if (!Schema::hasTable('service_events')) {

            Schema::create('service_events', function (Blueprint $table) {
                $table->id();
                $table->date('date');
                $table->string('service_name');
                $table->string('preacher');
                $table->text('preacher_description')->nullable();
                $table->text('message')->nullable();
                $table->integer('attendance_women')->default(0);
                $table->integer('attendance_men')->default(0);
                $table->integer('attendance_children')->default(0);
                $table->decimal('total_offerings', 15, 2)->default(0);
                $table->text('leaders_on_duty')->nullable();
                $table->timestamps();
            });

        }
    }

    public function down(): void
    {
        Schema::dropIfExists('service_events');
    }
};