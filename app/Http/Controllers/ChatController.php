<?php
namespace App\Http\Controllers;

use App\Events\MessageSent;
use App\Models\Message;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class ChatController extends Controller
{
    public function send(Request $request)
    {
        $message = Message::create([
            'user'    => $request->user,
            'message' => $request->message,
        ]);

        broadcast(new MessageSent($message->message, $message->user))->toOthers();

        Log::info('Mensaje broadcasted: ' . $message->message);

        return response()->json($message);
    }

    public function index(Request $request)
    {
        if ($request->has('user')) {
            return Message::where('user', $request->user)->get();
        }
        return Message::all();
    }
}