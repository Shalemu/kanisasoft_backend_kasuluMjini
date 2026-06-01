<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('members', function (Blueprint $table) {
            $table->id();

            // Link to users table
            $table->foreignId('user_id')->constrained('users')->onDelete('cascade');

            // Basic Info
            $table->string('full_name');
            $table->enum('gender', ['M', 'F']);
            $table->date('birth_date')->nullable();
            $table->string('birth_place')->nullable();
            $table->string('marital_status')->nullable();
            $table->string('spouse_name')->nullable();
            $table->integer('number_of_children')->nullable();
            $table->string('residential_zone')->nullable();
            $table->string('phone_number')->nullable();
            $table->string('email')->nullable();

            // Faith Info
            $table->date('date_of_conversion')->nullable();
            $table->string('church_of_conversion')->nullable();
            $table->date('baptism_date')->nullable();
            $table->string('baptism_place')->nullable();
            $table->string('baptizer_name')->nullable();
            $table->string('previous_church')->nullable();
            $table->string('church_service')->nullable();
            $table->string('service_duration')->nullable();

            // Education & Occupation
            $table->string('education_level')->nullable();
            $table->string('profession')->nullable();
            $table->string('occupation')->nullable();
            $table->string('work_place')->nullable();
            $table->string('work_contact')->nullable();

            // Family Info
            $table->boolean('lives_alone')->nullable();
            $table->text('lives_with')->nullable();

            // Office Use
            $table->string('membership_number')->nullable();
            $table->string('verified_by')->nullable();
            $table->date('membership_start_date')->nullable();
            $table->enum('membership_status', ['active', 'left', 'detained', 'deceased', 'lost'])->default('active');

            // Authorization flag: has admin authorized this user as a member?
            $table->boolean('is_authorized')->default(false);

            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('members');
    }
};
