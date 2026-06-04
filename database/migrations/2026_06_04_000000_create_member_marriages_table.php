<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('member_marriages', function (Blueprint $table) {
            $table->id();
            $table->foreignId('husband_id')->unique()->constrained('members')->cascadeOnDelete();
            $table->foreignId('wife_id')->unique()->constrained('members')->cascadeOnDelete();
            $table->date('married_at')->nullable();
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('member_marriages');
    }
};
