<?php

use App\Http\Controllers\Auth\AuthController;
use App\Http\Controllers\ScreeningController; 
use Illuminate\Foundation\Auth\EmailVerificationRequest;
use Illuminate\Support\Facades\Route;

Route::get('/email/verify/{id}/{hash}', [AuthController::class, 'verifyEmail'])->name('verification.verify');

Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);
Route::post('/email/resend', [AuthController::class, 'resendVerificationEmail']);

Route::middleware('auth:sanctum')->group(function () {
    Route::middleware('verified')->group(function () {
        Route::get('/univgo', [ScreeningController::class, 'index']);
        Route::post('/univgo', [ScreeningController::class, 'submitScreening']);
        Route::post('/change-password', [AuthController::class, 'changePassword']);
        Route::get('/profile', [AuthController::class, 'getProfile']);
        Route::put('/profile', [AuthController::class, 'updateProfile']); 
    });
});
