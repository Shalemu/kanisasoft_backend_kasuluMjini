<?php

// database/migrations/xxxx_xx_xx_add_quantity_to_assets_table.php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void {
        Schema::table('assets', function (Blueprint $table) {
            $table->unsignedInteger('quantity')->default(1)->after('category');
        });
    }

    public function down(): void {
        Schema::table('assets', function (Blueprint $table) {
            $table->dropColumn('quantity');
        });
    }
};
