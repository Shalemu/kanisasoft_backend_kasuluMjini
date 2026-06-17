<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('invoices', function (Blueprint $table) {
            if (! Schema::hasColumn('invoices', 'invoice_number')) {
                $table->string('invoice_number')->nullable();
            }
            if (! Schema::hasColumn('invoices', 'invoice_date')) {
                $table->date('invoice_date')->nullable();
            }
            if (! Schema::hasColumn('invoices', 'due_date')) {
                $table->date('due_date')->nullable();
            }
            if (! Schema::hasColumn('invoices', 'sub_total')) {
                $table->decimal('sub_total', 15, 2)->nullable();
            }
            if (! Schema::hasColumn('invoices', 'credit')) {
                $table->decimal('credit', 15, 2)->nullable()->default(0);
            }
            if (! Schema::hasColumn('invoices', 'total')) {
                $table->decimal('total', 15, 2)->nullable();
            }
            if (! Schema::hasColumn('invoices', 'status')) {
                $table->string('status')->default('unpaid');
            }
            if (! Schema::hasColumn('invoices', 'transactions')) {
                $table->json('transactions')->nullable();
            }
        });
    }

    public function down(): void
    {
        Schema::table('invoices', function (Blueprint $table) {
            $table->dropColumn([
                'invoice_number', 'invoice_date', 'due_date',
                'sub_total', 'credit', 'total', 'status', 'transactions',
            ]);
        });
    }
};
