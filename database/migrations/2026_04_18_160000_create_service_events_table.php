<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('service_events', function (Blueprint $table) {
            $table->id();
            $table->string('title');
            $table->date('date');
            $table->time('time')->nullable();
            $table->string('location')->nullable();
            $table->string('category')->nullable();
            $table->text('description')->nullable();
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('service_events');
    }
};
