<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        if (Schema::hasTable('person_access_tokens') && ! Schema::hasTable('personal_access_tokens')) {
            Schema::rename('person_access_tokens', 'personal_access_tokens');

            return;
        }

        if (! Schema::hasTable('personal_access_tokens')) {
            Schema::create('personal_access_tokens', function (Blueprint $table) {
                $table->id();
                $table->morphs('tokenable');
                $table->string('name');
                $table->string('token', 64)->unique();
                $table->text('abilities')->nullable();
                $table->timestamp('last_used_at')->nullable();
                $table->timestamp('expires_at')->nullable();
                $table->timestamps();
            });
        }
    }

    public function down(): void
    {
        if (Schema::hasTable('personal_access_tokens') && ! Schema::hasTable('person_access_tokens')) {
            Schema::rename('personal_access_tokens', 'person_access_tokens');
        }
    }
};
