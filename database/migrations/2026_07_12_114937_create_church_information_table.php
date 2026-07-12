<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('church_information', function (Blueprint $table) {

            $table->id();

            // Basic information
            $table->string('church_name');
            $table->text('about')->nullable();
            $table->text('history')->nullable();

            // Contact information
            $table->string('phone')->nullable();
            $table->string('email')->nullable();
            $table->string('website')->nullable();

            // Social media
            $table->string('facebook')->nullable();
            $table->string('instagram')->nullable();
            $table->string('youtube')->nullable();
            $table->string('whatsapp')->nullable();

            // Location
            $table->text('address')->nullable();

            // Google map coordinates
            $table->decimal('latitude', 10, 7)
                ->nullable();

            $table->decimal('longitude', 10, 7)
                ->nullable();

            // Google maps direction link
            $table->text('map_link')
                ->nullable();

            // Church image/logo
            $table->string('image')
                ->nullable();

            // Sharing slug
            $table->string('slug')
                ->unique();

            // Status
            $table->boolean('is_active')
                ->default(true);


            // Audit
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
        Schema::dropIfExists('church_information');
    }
};