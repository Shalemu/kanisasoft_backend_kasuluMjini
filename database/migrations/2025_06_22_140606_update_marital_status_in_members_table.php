<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    public function up(): void
    {
        // Optional: clear bad values first
        DB::table('members')
            ->whereNotIn('marital_status', ['Ameoa', 'Ameolewa', 'Hajaoa', 'Hajaolewa', 'Mjane', 'Mgane'])
            ->update(['marital_status' => null]);

        Schema::table('members', function (Blueprint $table) {
            $table->enum('marital_status', ['Ameoa', 'Ameolewa', 'Hajaoa', 'Hajaolewa', 'Mjane', 'Mgane'])
                ->nullable()
                ->change();
        });
    }

    public function down(): void
    {
        Schema::table('members', function (Blueprint $table) {
            $table->string('marital_status')->nullable()->change();
        });
    }
};
