<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class PortfolioController extends Controller
{
    public function home()
    {
        return view('index');
    }

    // About page
    public function about()
    {
        return view('about');
    }

    // Projects page
    public function projects()
    {
        return view('projects');
    }

    // Contact page
    public function contact()
    {
        return view('contact');
    }
}