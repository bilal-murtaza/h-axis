<?php

namespace App\Http\Middleware;

use Closure;

class HandleAppearance
{
    public function handle($request, Closure $next)
    {
        // Your logic here
        return $next($request);
    }
}
