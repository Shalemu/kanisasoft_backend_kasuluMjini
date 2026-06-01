<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('leaders', function (Blueprint $table) {
            $table->id();
            $table->string('leader_code')->unique(); // Unique leader identifier
            $table->foreignId('leadership_role_id')->constrained('leadership_roles')->onDelete('cascade');
            $table->foreignId('user_id')->nullable()->constrained('users')->nullOnDelete();

            $table->string('full_name');  
            $table->string('phone');
            $table->string('email')->nullable();

            $table->timestamps();
        });

    }

    public function down(): void
    {
        Schema::dropIfExists('leaders');
    }
};
