<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('sms_logs', function (Blueprint $table) {
            $table->id();
            $table->string('recipient'); // Phone number
            $table->string('type'); // all, male, female, group, individual
            $table->text('message');
            $table->string('status')->default('pending'); // sent, failed
            $table->json('response')->nullable(); // Beem API response
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('sms_logs');
    }
};
