<?php

use App\Http\Controllers\Auth\AuthController;
use Illuminate\Foundation\Auth\EmailVerificationRequest;
use Illuminate\Support\Facades\Route;


Route::get('/email/verify/{id}/{hash}', [AuthController::class, 'verifyEmail'])->name('verification.verify');

Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);
Route::post('/email/resend', [AuthController::class, 'resendVerificationEmail']);

Route::middleware('auth:sanctum')->group(function () {
    Route::middleware('verified')->group(function () {
        Route::get('/mental-health-screening', [ScreeningController::class, 'index']);
        Route::post('/mental-health-screening', [ScreeningController::class, 'submitScreening']);
    });
});
