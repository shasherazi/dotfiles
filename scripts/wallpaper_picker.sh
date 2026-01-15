#!/bin/sh

# Default wallpaper directory if not set
WALLPAPER_DIR=/home/shasherazi/wallpapers

WALLPAPER=$(for a in ~/wallpapers/*; do echo -en "$(basename "$a")\0icon\x1f$a\n" ; done | rofi -dmenu -config ~/.config/rofi/wallpaper.rasi)

if [ -z "$WALLPAPER" ]; then
    exit 0
fi

WALLPAPER=~/wallpapers/"$WALLPAPER"

if [ -n "$WALLPAPER" ]; then
    if [ "$XDG_SESSION_TYPE" = "x11" ]; then
        nitrogen --set-zoom-fill "$WALLPAPER"
    elif [ "$XDG_SESSION_TYPE" = "wayland" ]; then
        hyprctl hyprpaper reload ,"$WALLPAPER"
    else
        echo "Unsupported desktop environment: $XDG_SESSION_TYPE"
    fi
    dunstify -t 3000 -r 1337 "Wallpaper changed to $(basename "$WALLPAPER")"
fi
