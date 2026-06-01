<?php

namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Notifications\Notification;
use Illuminate\Notifications\Messages\MailMessage;
use App\Models\User;

class NewUserRegistered extends Notification
{
    use Queueable;

    protected $user;

    public function __construct(User $user)
    {
        $this->user = $user;
    }

    public function via($notifiable)
    {
        // This tells Laravel to send via email
        return ['mail'];
    }

    public function toMail($notifiable)
    {
        return (new MailMessage)
                    ->subject('New User Registered')
                    ->greeting('Hello ' . $notifiable->full_name)
                    ->line('A new user has registered: ' . $this->user->full_name)
                    ->line('Email: ' . $this->user->email)
                    ->line('Phone: ' . $this->user->phone);
    }
}
