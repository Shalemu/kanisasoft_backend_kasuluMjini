<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up()
    {
        Schema::table('members', function (Blueprint $table) {
            $table->string('birth_district')->nullable()->after('birth_place');
            $table->string('baptizer_title')->nullable()->after('baptizer_name');
    
            $table->string('previous_church_status')->nullable()->after('previous_church');
            $table->string('tangu_lini')->nullable()->after('previous_church_status');
    
            $table->string('family_role')->nullable()->after('lives_with');
            $table->string('live_with_who')->nullable()->after('family_role');
    
            $table->string('next_of_kin')->nullable()->after('live_with_who');
            $table->string('next_of_kin_phone')->nullable()->after('next_of_kin');
        });
    }
    
    public function down()
    {
        Schema::table('members', function (Blueprint $table) {
            $table->dropColumn([
                'birth_district',
                'baptizer_title',
                'previous_church_status',
                'tangu_lini',
                'family_role',
                'live_with_who',
                'next_of_kin',
                'next_of_kin_phone',
            ]);
        });
    }    
};
