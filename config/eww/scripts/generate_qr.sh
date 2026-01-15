#!/bin/bash

# Get the text from eww variable
text=$(eww get qr_text)

# Generate ASCII QR and update eww variable
if [ -n "$text" ]; then
    ascii_qr=$(echo "$text" | qrencode -t UTF8)
    eww update qr_ascii="$ascii_qr"
    
    # Auto-close after 10 seconds (optional)
    # sleep 10 && eww close qr_input &
else
    eww update qr_ascii="Enter text to generate QR code"
fi