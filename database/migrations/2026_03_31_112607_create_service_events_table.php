<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('service_events', function (Blueprint $table) {
            $table->id();
            $table->date('date'); // Date of the service
            $table->string('service_name'); // Name/type of service
            $table->string('preacher'); // Name of the preacher
            $table->text('message')->nullable(); // Sermon/message content
            $table->integer('attendance_women')->default(0); // Number of women
            $table->integer('attendance_men')->default(0); // Number of men
            $table->integer('attendance_children')->default(0); // Number of children
            $table->decimal('total_offerings', 15, 2)->default(0); // Total offerings
            $table->text('leaders_on_duty')->nullable(); // Leaders on duty (names)
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('service_events');
    }
};