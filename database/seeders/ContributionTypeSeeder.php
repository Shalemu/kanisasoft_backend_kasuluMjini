<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Carbon;

class ContributionTypeSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $types = [
            'Sadaka',
            'Fungu la Kumi',
            'Maendeleo',
            'Misaada Maalum',
        ];

        foreach ($types as $type) {
            DB::table('contribution_types')->updateOrInsert(
                ['name' => $type],
                ['created_at' => Carbon::now(), 'updated_at' => Carbon::now()]
            );
        }
    }
}
