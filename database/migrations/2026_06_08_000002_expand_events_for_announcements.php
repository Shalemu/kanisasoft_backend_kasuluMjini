<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('events', function (Blueprint $table) {
            if (! Schema::hasColumn('events', 'type')) {
                $table->string('type')->default('Tukio');
            }

            if (! Schema::hasColumn('events', 'start_date')) {
                $table->date('start_date')->nullable();
            }

            if (! Schema::hasColumn('events', 'end_date')) {
                $table->date('end_date')->nullable();
            }

            if (! Schema::hasColumn('events', 'start_time')) {
                $table->time('start_time')->nullable();
            }

            if (! Schema::hasColumn('events', 'audience_group_ids')) {
                $table->json('audience_group_ids')->nullable();
            }
        });

        if (Schema::hasColumn('events', 'date') && Schema::hasColumn('events', 'start_date')) {
            DB::table('events')
                ->whereNull('start_date')
                ->update(['start_date' => DB::raw('date')]);
        }

        if (Schema::hasColumn('events', 'time') && Schema::hasColumn('events', 'start_time')) {
            DB::table('events')
                ->whereNull('start_time')
                ->update(['start_time' => DB::raw('time')]);
        }
    }

    public function down(): void
    {
        Schema::table('events', function (Blueprint $table) {
            foreach (['type', 'start_date', 'end_date', 'start_time', 'audience_group_ids'] as $column) {
                if (Schema::hasColumn('events', $column)) {
                    $table->dropColumn($column);
                }
            }
        });
    }
};
