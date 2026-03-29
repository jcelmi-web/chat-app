<?php

use Illuminate\Support\Facades\Route;
use App\Events\MessageSent;

Route::get('/', function () {
    return view('welcome');
});

