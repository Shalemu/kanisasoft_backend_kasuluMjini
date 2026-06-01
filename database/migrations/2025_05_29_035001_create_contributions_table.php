<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void {
        Schema::create('contributions', function (Blueprint $table) {
            $table->id();
            $table->date('date');
            $table->string('type');
            $table->decimal('amount', 12, 2);
            $table->string('method');

            // 🧠 EITHER mshirika (linked user) OR manual name (mwingine)
            $table->unsignedBigInteger('user_id')->nullable(); // nullable for "mwingine"
            $table->string('giver_name')->nullable(); // manually typed name

            $table->timestamps();

            $table->foreign('user_id')->references('id')->on('users')->onDelete('set null');
        });
    }

    public function down(): void {
        Schema::dropIfExists('contributions');
    }
};
