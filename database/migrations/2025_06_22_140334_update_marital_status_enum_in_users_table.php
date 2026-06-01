<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    public function up(): void
    {
        // Step 1: Temporarily make the column nullable (important before update)
        Schema::table('users', function (Blueprint $table) {
            $table->string('marital_status')->nullable()->change(); // make it nullable
        });

        // Step 2: Update invalid values to NULL to prevent SQL errors
        DB::table('users')
            ->whereNotIn('marital_status', ['Ameoa', 'Ameolewa', 'Hajaoa', 'Hajaolewa', 'Mjane', 'Mgane'])
            ->update(['marital_status' => null]);

        // Step 3: Now safely change it to ENUM with new values
        Schema::table('users', function (Blueprint $table) {
            $table->enum('marital_status', ['Ameoa', 'Ameolewa', 'Hajaoa', 'Hajaolewa', 'Mjane', 'Mgane'])
                  ->nullable()
                  ->change();
        });
    }

    public function down(): void
    {
        Schema::table('users', function (Blueprint $table) {
            $table->enum('marital_status', ['Ndoa', 'Bila ndoa'])->nullable()->change();
        });
    }
};
