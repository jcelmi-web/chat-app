<?php
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\ChatController;

Route::get('/messages',  [ChatController::class, 'index']);
Route::post('/messages', [ChatController::class, 'send']);