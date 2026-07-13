<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('support_requests', function (Blueprint $table) {
            if (! Schema::hasColumn('support_requests', 'department')) {
                $table->string('department')->default('support'); // billing, support
            }
            if (! Schema::hasColumn('support_requests', 'church')) {
                $table->string('church')->nullable();
            }
            if (! Schema::hasColumn('support_requests', 'name')) {
                $table->string('name')->nullable();
            }
            if (! Schema::hasColumn('support_requests', 'phone')) {
                $table->string('phone')->nullable();
            }
            if (! Schema::hasColumn('support_requests', 'email')) {
                $table->string('email')->nullable();
            }
        });
    }

    public function down(): void
    {
        Schema::table('support_requests', function (Blueprint $table) {
            $table->dropColumn(['department', 'church', 'name', 'phone', 'email']);
        });
    }
};
