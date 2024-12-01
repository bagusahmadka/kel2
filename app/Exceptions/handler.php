<?php

namespace App\Exceptions;

use Illuminate\Foundation\Exceptions\Handler as ExceptionHandler;
use Throwable;

class Handler extends ExceptionHandler
{
    /**
     * Daftar jenis exception yang tidak dilaporkan.
     *
     * @var array<int, class-string<Throwable>>
     */
    protected $dontReport = [
        //
    ];

    /**
     * Daftar input yang tidak pernah diflash untuk pengecualian validasi.
     *
     * @var array<int, string>
     */
    protected $dontFlash = [
        'current_password',
        'password',
        'password_confirmation',
    ];

    /**
     * Melaporkan atau mencatat exception.
     */
    public function report(Throwable $exception): void
    {
        \Log::error('Exception terjadi', [
            'message' => $exception->getMessage(),
            'file' => $exception->getFile(),
            'line' => $exception->getLine(),
        ]);
    
        parent::report($exception);
    }
    
    /**
     * Render exception menjadi respons HTTP.
     */
    public function render($request, Throwable $exception)
    {
        if ($request->expectsJson()) {
            return response()->json([
                'message' => $exception->getMessage(),
                'status_code' => $exception->getCode() ?: 500
            ], $exception->getCode() ?: 500);
        }

        return parent::render($request, $exception);
    }
}
