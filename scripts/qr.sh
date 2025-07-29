#!/bin/sh

text=$(echo "" | rofi -dmenu -p "QR encode:" -config "~/.config/rofi/qr.rasi")
[ -n "$text" ] && dunstify "$(echo "$text" | qrencode -t UTF8)"
