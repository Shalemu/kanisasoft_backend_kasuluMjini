<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('contributions', function (Blueprint $table) {
            if (! Schema::hasColumn('contributions', 'member_name')) {
                $table->string('member_name')->nullable();
            }
            if (! Schema::hasColumn('contributions', 'donor_name')) {
                $table->string('donor_name')->nullable();
            }
            if (! Schema::hasColumn('contributions', 'payment_method')) {
                $table->string('payment_method')->nullable();
            }
            if (! Schema::hasColumn('contributions', 'category')) {
                $table->string('category')->nullable();
            }
            if (! Schema::hasColumn('contributions', 'contribution_date')) {
                $table->date('contribution_date')->nullable();
            }
        });
    }

    public function down(): void
    {
        Schema::table('contributions', function (Blueprint $table) {
            $table->dropColumn(['member_name', 'donor_name', 'payment_method', 'category', 'contribution_date']);
        });
    }
};
