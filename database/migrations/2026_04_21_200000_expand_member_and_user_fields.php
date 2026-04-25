<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        // ── Members table ──
        Schema::table('members', function (Blueprint $table) {
            // Birth location breakdown
            $table->string('birth_region')->nullable()->after('birth_place');
            // birth_district already exists
            $table->string('birth_ward')->nullable()->after('birth_district');
            $table->string('birth_street')->nullable()->after('birth_ward');

            // Residential location
            $table->string('residential_ward')->nullable()->after('residential_zone');
            $table->string('residential_street')->nullable()->after('residential_ward');

            // Marriage type
            $table->enum('marriage_type', ['Kikristo', 'Kiserikali', 'Kienyeji'])->nullable()->after('marital_status');

            // Disability
            $table->boolean('has_disability')->default(false)->after('email');
            $table->string('disability_description')->nullable()->after('has_disability');

            // Communion participation (Meza ya Bwana)
            $table->boolean('participates_communion')->nullable()->after('service_duration');

            // Split conversion date into day/month/year
            $table->unsignedSmallInteger('conversion_year')->nullable()->after('date_of_conversion');
            $table->unsignedTinyInteger('conversion_month')->nullable()->after('conversion_year');
            $table->unsignedTinyInteger('conversion_day')->nullable()->after('conversion_month');

            // Split baptism date into day/month/year
            $table->unsignedSmallInteger('baptism_year')->nullable()->after('baptism_date');
            $table->unsignedTinyInteger('baptism_month')->nullable()->after('baptism_year');
            $table->unsignedTinyInteger('baptism_day')->nullable()->after('baptism_month');
        });

        // ── Users table ──
        Schema::table('users', function (Blueprint $table) {
            $table->string('birth_region')->nullable()->after('birth_place');
            // birth_district already exists on users
            $table->string('birth_ward')->nullable()->after('birth_district');
            $table->string('birth_street')->nullable()->after('birth_ward');

            $table->string('residential_ward')->nullable()->after('zone');
            $table->string('residential_street')->nullable()->after('residential_ward');

            $table->enum('marriage_type', ['Kikristo', 'Kiserikali', 'Kienyeji'])->nullable()->after('marital_status');

            $table->boolean('has_disability')->default(false)->after('email');
            $table->string('disability_description')->nullable()->after('has_disability');
        });
    }

    public function down(): void
    {
        Schema::table('members', function (Blueprint $table) {
            $table->dropColumn([
                'birth_region', 'birth_ward', 'birth_street',
                'residential_ward', 'residential_street',
                'marriage_type',
                'has_disability', 'disability_description',
                'participates_communion',
                'conversion_year', 'conversion_month', 'conversion_day',
                'baptism_year', 'baptism_month', 'baptism_day',
            ]);
        });

        Schema::table('users', function (Blueprint $table) {
            $table->dropColumn([
                'birth_region', 'birth_ward', 'birth_street',
                'residential_ward', 'residential_street',
                'marriage_type',
                'has_disability', 'disability_description',
            ]);
        });
    }
};
