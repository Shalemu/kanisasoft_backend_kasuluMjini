<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('daily_words', function (Blueprint $table) {
            $table->id();
            $table->date('scheduled_date')->unique();
            $table->string('scripture_reference');
            $table->text('verse_text');
            $table->text('explanation');
            $table->string('author_name')->nullable();
            $table->foreignId('created_by')->nullable()->constrained('users')->nullOnDelete();
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('daily_words');
    }
};
