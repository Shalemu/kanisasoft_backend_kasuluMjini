<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('contributions', function (Blueprint $table) {
            if (! Schema::hasColumn('contributions', 'member_id')) {
                $table->foreignId('member_id')->nullable()->constrained('users');
            }
            if (! Schema::hasColumn('contributions', 'membership_number')) {
                $table->string('membership_number')->nullable();
            }
            if (! Schema::hasColumn('contributions', 'pledge_amount')) {
                $table->decimal('pledge_amount', 15, 2)->nullable();
            }
            if (! Schema::hasColumn('contributions', 'total_paid')) {
                $table->decimal('total_paid', 15, 2)->nullable();
            }
        });
    }

    public function down(): void
    {
        Schema::table('contributions', function (Blueprint $table) {
            $table->dropColumn(['member_id', 'membership_number', 'pledge_amount', 'total_paid']);
        });
    }
};
