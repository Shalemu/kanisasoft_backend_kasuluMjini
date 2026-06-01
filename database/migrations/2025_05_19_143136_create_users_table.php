<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateUsersTable extends Migration
{
    public function up()
    {
        Schema::create('users', function (Blueprint $table) {
            $table->id();

            $table->string('full_name');
            $table->enum('gender', ['M', 'F']); // ✅ Changed to standard values
            $table->date('birth_date');
            $table->string('birth_place');
            $table->enum('marital_status', ['Ndoa', 'Bila ndoa']);
            $table->string('spouse_name')->nullable();
            $table->integer('children_count')->default(0);
            $table->string('zone');
            $table->string('phone')->unique();
            $table->string('email')->unique();

            $table->string('password');
            $table->rememberToken();
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('users');
    }
}
