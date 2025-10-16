#!/bin/sh

# Default wallpaper directory if not set
WALLPAPER_DIR=/home/shasherazi/wallpapers

# Check if running on Xorg or Wayland
if [ "$XDG_SESSION_TYPE" = "x11" ]; then
	# Set a random wallpaper using nitrogen with zoom-fill and random options
	nitrogen --set-zoom-fill --random
elif [ "$XDG_SESSION_TYPE" = "wayland" ]; then
	# Set a random wallpaper using swaybg with a transition step
	WALLPAPER=$(find "$WALLPAPER_DIR" -type f -printf "%p\n" | shuf -n 1)
	hyprctl hyprpaper reload ,"$WALLPAPER"
	dunstify -t 3000 -r 1337 "Wallpaper changed to $(basename "$WALLPAPER")"
else
	echo "Unsupported desktop environment: $XDG_SESSION_TYPE"
fi
