<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Auth\Events\Registered;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\URL;
use Illuminate\Validation\ValidationException;
use Illuminate\Database\QueryException;
use Symfony\Component\HttpKernel\Exception\HttpException;
use Illuminate\Validation\Rule;
use Illuminate\Contracts\Auth\MustVerifyEmail;

class AuthController extends Controller
{
    public function register(Request $request)
    {
        try {
            $validatedData = $request->validate([
                'name' => [
                    'required',
                    'string',
                    'max:255',
                    Rule::unique('users', 'name'),
                ],
                'email' => [
                    'required',
                    'string',
                    'email',
                    'max:255',
                    Rule::unique('users', 'email'),
                ],

                'password' => 'required|string|min:8|confirmed',
            ]);

            $user = User::create([
                'name' => $validatedData['name'],
                'email' => $validatedData['email'],
                'password' => Hash::make($validatedData['password']),
                'email_verified_at' => null
            ]);

            event(new Registered($user));
            return response()->json([
                'message' => 'Register Succsess, Mohon verifikasi email anda',
                'verification_url' => $this->getVerificationUrl($user)
            ], 201);

        } catch (ValidationException $e) {
            $errors = $e->errors();
            $errorMessage = '';

            if (isset($errors['name'])) {
                $errorMessage .= 'Nama sudah digunakan';
            }
            if (isset($errors['email'])) {
                $errorMessage .= 'Email sudah pernah digunakan';
            }

            if (empty($errorMessage)) {
                $errorMessage = 'Mohon mengisi semua data';
            }
            return response()->json(['message' => $errorMessage, 'errors' => $errors], 422);
        } catch (QueryException $e) {
            return response()->json(['message' => "Terjadi kesalahan koneksi"], 500);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Terjadi kesalahan sistem, Mohon coba lagi nanti'], 500);
        }
    }
    public function verifyEmail(Request $request, $id, $hash)
    {
        try {
            $user = User::findOrFail($id);

            if (!hash_equals((string) $hash, sha1($user->getEmailForVerification()))) {
                return response()->json(['message' => 'Invalid verification link'], 400);
            }

            if ($user->hasVerifiedEmail()) {
                return response()->json(['message' => 'Email already verified'], 200);
            }

            $user->markEmailAsVerified();

            return response()->json(['message' => 'Email verified successfully'], 200);

        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            return response()->json(['message' => 'User tidak ditemukan'], 404);
        } catch (\Exception $e) {
            return response()->json(['message' => $e ], 500);
        }
    }

    public function resendVerificationEmail(Request $request)
    {
        try {
            $user = User::where('email', $request->input('email'))->first();

            if (!$user) {
                return response()->json(['message' => 'User tidak ditemukan'], 404);
            }
            if ($user->hasVerifiedEmail()) {
                return response()->json(['message' => 'Email sudah terverifikasi'], 200);
            }
            $user->sendEmailVerificationNotification();

            return response()->json(['message' => 'Email Verifikasi terkirim'], 200);

        } catch (\Exception $e) {
            return response()->json(['message' => 'Gagal mengirim Email Verifikasi'], 500);
        }
    }
    private function getVerificationUrl($user)
    {
        return URL::temporarySignedRoute(
            'verification.verify',
            now()->addMinutes(60),
            ['id' => $user->getKey(), 'hash' => sha1($user->getEmailForVerification())]
        );
    }



    public function login(Request $request)
    {
        try {
            $request->validate([
                'email' => 'required|string|email',
                'password' => 'required|string',
            ]);

            if (!Auth::attempt($request->only('email', 'password'))) {
                return response()->json([
                    'message' => ['email / password salah'],
                ]);
            }

            $user = Auth::user();

            if (!$user->hasVerifiedEmail()) {
                Auth::logout();
                return response()->json([
                    'message' => 'Please verify your email before logging in.',
                    'verification_url' => $this->getVerificationUrl($user)
                ], 403);
            }

            $token = $user->createToken('api_token')->plainTextToken;

            return response()->json([
                'message' => 'Login successful',
                'token' => $token,
                'user' => $user
            ], 200);

        } catch (ValidationException $e) {
            return response()->json(['errors' => $e->errors()], 422);
        } catch (\Exception $e) {
            return response()->json(['message' => "Terjadi kesalahan sistem"], 500);
        }
    }

    public function getProfile(Request $request) {
        if (Auth::check()) {
            $user = Auth::user();
            return response()->json(['status' => 'success', 'user' => $user], 200);
        }

        return response()->json(['message' => 'User is not authenticated.'], 40);

    }




}

