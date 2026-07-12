<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\ChurchInformation;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;

class ChurchInformationController extends Controller
{

    /**
     * View church information inside system
     */
    public function index()
    {

        $church = ChurchInformation::where('is_active', true)
            ->latest()
            ->first();


        return response()->json([

            'success'=>true,
            'data'=>$church

      ]);

    }

    /**
     * Public page access
     * No login required
     */
    public function show($slug)
    {

        $church = ChurchInformation::where('slug',$slug)
            ->where('is_active',true)
            ->firstOrFail();


        return response()->json([

            'success'=>true,
            'data'=>$church

        ]);

    }

    /**
     * Admin create church information
     */
    public function store(Request $request)
    {

        try {


            $validated = $request->validate([

                'church_name'
                    =>'required|string|max:255',

                'about'
                    =>'nullable|string',

                'history'
                    =>'nullable|string',

                'phone'
                    =>'nullable|string|max:50',

                'email'
                    =>'nullable|email',

                'website'
                    =>'nullable|url',

                'facebook'
                    =>'nullable|url',

                'instagram'
                    =>'nullable|url',

                'youtube'
                    =>'nullable|url',

                'whatsapp'
                    =>'nullable|string',

                'address'
                    =>'nullable|string',

                'latitude'
                    =>'nullable',

                'longitude'
                    =>'nullable',

                'map_link'
                    =>'nullable|url',

                'image'
                    =>'nullable|image|max:5120',

                'is_active'
                    =>'nullable|boolean',

            ]);


            if($request->hasFile('image')){

                $validated['image'] =
                    $request->file('image')
                    ->store('church','public');

            }


            $validated['slug'] =
                Str::slug($request->church_name);

            $validated['created_by'] =
                auth()->id();

            $church =
                ChurchInformation::create($validated);

            return response()->json([

                'success'=>true,
                'message'=>'Taarifa za kanisa zimehifadhiwa',
                'data'=>$church

            ],201);


        } catch(\Throwable $e){


            return response()->json([

                'success'=>false,
                'message'=>$e->getMessage(),
                'line'=>$e->getLine()

            ],500);

        }

    }

    /**
     * Admin update
     */
    public function update(Request $request, $id)
    {


        try {


            $church =
                ChurchInformation::findOrFail($id);

            $validated = $request->validate([

                'church_name'
                    =>'required|string|max:255',

                'about'
                    =>'nullable|string',

                'history'
                    =>'nullable|string',

                'phone'
                    =>'nullable|string|max:50',

                'email'
                    =>'nullable|email',

                'website'
                    =>'nullable|url',

                'facebook'
                    =>'nullable|url',

                'instagram'
                    =>'nullable|url',

                'youtube'
                    =>'nullable|url',

                'whatsapp'
                    =>'nullable|string',

                'address'
                    =>'nullable|string',

                'latitude'
                    =>'nullable',

                'longitude'
                    =>'nullable',

                'map_link'
                    =>'nullable|url',


                'image'
                    =>'nullable|image|max:5120',

                'is_active'
                   =>'nullable|boolean',

            ]);


            if($request->hasFile('image')){

                if($church->image){

                    Storage::disk('public')
                        ->delete($church->image);

                }
                $validated['image'] =
                    $request->file('image')
                    ->store('church','public');

            }


            if($request->church_name){

                $validated['slug'] =
                    Str::slug($request->church_name);
            }

            $validated['updated_by'] =
                auth()->id();

            $church->update($validated);

            return response()->json([
                'success'=>true,
                'message'=>'Taarifa za kanisa zimebadilishwa',
                'data'=>$church

            ]);


        } catch(\Throwable $e){


            return response()->json([

                'success'=>false,

                'message'=>$e->getMessage(),

                'line'=>$e->getLine()

            ],500);

        }
    }
    /**
     * Delete
     */
    public function destroy($id)
    {
        $church =
            ChurchInformation::findOrFail($id);
        if($church->image){
            Storage::disk('public')
                ->delete($church->image);

        }

        $church->delete();
        return response()->json([
            'success'=>true,
            'message'=>'Taarifa zimefutwa'
        ]);
    }
}