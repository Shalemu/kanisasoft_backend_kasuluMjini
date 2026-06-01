<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class LeadershipRolesSeeder extends Seeder
{
    public function run(): void
    {
        $roles = [
            ['title' => 'admin', 'requires_member' => false, 'protected' => true],
            ['title' => 'mchungaji', 'requires_member' => true, 'protected' => true],
            ['title' => 'katibu', 'requires_member' => true, 'protected' => true],
            ['title' => 'mtunza hazina', 'requires_member' => true, 'protected' => true], // simplified from "mtunza hazina"
        ];

        foreach ($roles as $role) {
            DB::table('leadership_roles')->updateOrInsert(
                ['title' => $role['title']],
                $role
            );
        }
    }
}
