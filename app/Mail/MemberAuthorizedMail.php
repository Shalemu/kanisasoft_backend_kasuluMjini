<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Mail\Mailables\Content;
use Illuminate\Mail\Mailables\Envelope;
use Illuminate\Queue\SerializesModels;

class MemberAuthorizedMail extends Mailable

{
    use Queueable, SerializesModels;

    public $fullName;
    public $membershipNumber;

    /**
     * Create a new message instance.
     */
    public function __construct(string $fullName, string $membershipNumber)
    {
        $this->fullName = $fullName;
        $this->membershipNumber = $membershipNumber;
    }

    /**
     * Get the message envelope.
     */
    public function envelope(): Envelope
    {
        return new Envelope(
            subject: 'Membership Authorized',
        );
    }

    /**
     * Get the message content definition.
     */ 
 public function build()
{
    return $this->subject('Membership Authorized')



      ->html("<p>Habari {$this->fullName},usajili wako FPCT Kurasini umekamilika. Namba yako ya ushirika ni {$this->membershipNumber} <br> Karibu FPCT Kurasini.</p>");
                // ->html("<p>Hello {$this->fullName}, your membership number is {$this->membershipNumber}</p>");
        
}


    /**
     * Get the attachments for the message.
     *
     * @return array<int, \Illuminate\Mail\Mailables\Attachment>
     */
    public function attachments(): array
    {
        return [];
    }
}
