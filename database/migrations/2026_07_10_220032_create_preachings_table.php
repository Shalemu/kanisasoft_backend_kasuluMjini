<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('preachings', function (Blueprint $table) {

            $table->id();

            $table->date('date');

            $table->string('preacher_name');

            $table->string('title');

            $table->text('description')
                  ->nullable();

            // PDF file path
            $table->string('pdf_file')
                  ->nullable();

            // Youtube/Facebook external link
            $table->string('video_link')
                  ->nullable();

            $table->boolean('is_active')
                  ->default(true);

            $table->foreignId('created_by')
                  ->nullable()
                  ->constrained('users')
                  ->nullOnDelete();

            $table->foreignId('updated_by')
                  ->nullable()
                  ->constrained('users')
                  ->nullOnDelete();

            $table->timestamps();

        });
    }


    public function down(): void
    {
        Schema::dropIfExists('preachings');
    }
};