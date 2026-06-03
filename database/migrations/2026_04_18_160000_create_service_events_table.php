<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        if (!Schema::hasTable('service_events')) {
            Schema::create('service_events', function (Blueprint $table) {
                $table->id();
                $table->string('title');
                $table->date('date');
                $table->time('time')->nullable();
                $table->string('location')->nullable();
                $table->string('category')->nullable();
                $table->text('description')->nullable();
                $table->timestamps();
            });

            return;
        }

        Schema::table('service_events', function (Blueprint $table) {
            if (!Schema::hasColumn('service_events', 'title')) {
                $table->string('title')->nullable()->after('id');
            }

            if (!Schema::hasColumn('service_events', 'time')) {
                $table->time('time')->nullable()->after('date');
            }

            if (!Schema::hasColumn('service_events', 'location')) {
                $table->string('location')->nullable()->after('time');
            }

            if (!Schema::hasColumn('service_events', 'category')) {
                $table->string('category')->nullable()->after('location');
            }

            if (!Schema::hasColumn('service_events', 'description')) {
                $table->text('description')->nullable()->after('category');
            }
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('service_events');
    }
};
