<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('guests', function (Blueprint $table) {
            $table->id();
            $table->string('full_name');
            $table->string('phone')->nullable();
            $table->string('church_origin')->nullable();
            $table->date('visit_date')->nullable();
            $table->boolean('prayer')->default(false);
            $table->boolean('salvation')->default(false);
            $table->boolean('joining')->default(false);
            $table->boolean('travel')->default(false);
            $table->string('other')->nullable();
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('guests');
    }
};
