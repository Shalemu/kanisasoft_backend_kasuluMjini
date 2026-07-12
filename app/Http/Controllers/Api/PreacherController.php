<?php

namespace App\Http\Controllers\Api;


use App\Http\Controllers\Controller;
use App\Models\Preaching;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;



class PreacherController extends Controller
{


    public function index()
    {

        $preachings = Preaching::latest()
            ->get();


        return response()->json([
            'success'=>true,
            'data'=>$preachings
        ]);

    }



public function store(Request $request)
{
    try {

        $validated = $request->validate([

            'date' => 'required|date',

            'preacher_name' => 'required|string|max:255',

            'title' => 'required|string|max:255',

            'description' => 'nullable|string',

            'pdf_file' => 'nullable|mimes:pdf|max:5120',

            'video_link' => 'nullable|url',

            'is_active' => 'nullable|boolean',

        ]);


        // Upload PDF
        if ($request->hasFile('pdf_file')) {

            $validated['pdf_file'] = 
                $request->file('pdf_file')
                ->store('preachings', 'public');

        }


        // User who created
        $validated['created_by'] = auth()->id();


        // Save
        $preaching = Preaching::create($validated);


        // Add PDF URL for frontend
        $preaching->pdf_url = $preaching->pdf_file
            ? asset('storage/' . $preaching->pdf_file)
            : null;


        return response()->json([

            'success' => true,

            'message' => 'Mahubiri yameongezwa',

            'data' => $preaching

        ], 201);


    } catch (\Throwable $e) {


        return response()->json([

            'success' => false,

            'message' => $e->getMessage(),

            'line' => $e->getLine(),

            'file' => $e->getFile(),

        ], 500);


    }
}



    public function show(Preaching $preaching)
    {

        return response()->json([

            'success'=>true,

            'data'=>$preaching

        ]);

    }





    public function update(Request $request, Preaching $preaching)
    {


        $validated = $request->validate([

            'date'=>'required|date',

            'preacher_name'
                =>'required|string|max:255',

            'title'
                =>'required|string|max:255',

            'description'
                =>'nullable|string',

            'pdf_file'
                =>'nullable|mimes:pdf|max:5120',

            'video_link'
                =>'nullable|url',

            'is_active'
                =>'nullable|boolean',

        ]);



        if($request->hasFile('pdf_file')){


            if($preaching->pdf_file){

                Storage::disk('public')
                ->delete($preaching->pdf_file);

            }


            $validated['pdf_file'] =
                $request->file('pdf_file')
                ->store('preachings','public');

        }



        $validated['updated_by'] =
            auth()->id();



        $preaching->update($validated);



        return response()->json([

            'success'=>true,

            'message'=>'Mahubiri yamebadilishwa',

            'data'=>$preaching

        ]);

    }





    public function destroy(Preaching $preaching)
    {


        if($preaching->pdf_file){

            Storage::disk('public')
            ->delete($preaching->pdf_file);

        }


        $preaching->delete();



        return response()->json([

            'success'=>true,

            'message'=>'Mahubiri yamefutwa'

        ]);

    }

}