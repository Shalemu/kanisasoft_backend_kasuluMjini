<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('zaka', function (Blueprint $table) {
            $table->id();
            $table->date('date');
            $table->foreignId('member_id')->nullable()->constrained('users');
            $table->string('member_name')->nullable();
            $table->string('membership_number')->nullable();
            $table->decimal('amount', 15, 2)->default(0);
            $table->foreignId('created_by')->nullable()->constrained('users');
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('zaka');
    }
};
