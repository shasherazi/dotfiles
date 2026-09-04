#!/bin/sh

WALLPAPER=$(
  for a in ~/wallpapers/*; do
    printf "%s\0icon\x1f%s\n" "${a##*/}" "$a"
  done | shuf | rofi -dmenu -config ~/.config/rofi/wallpaper.rasi
)

if [ -z "$WALLPAPER" ]; then
  exit 0
fi

WALLPAPER=~/wallpapers/"$WALLPAPER"

if [ -n "$WALLPAPER" ]; then
  if [ "$XDG_SESSION_TYPE" = "x11" ]; then
    nitrogen --set-zoom-fill "$WALLPAPER"
  elif [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    hyprctl hyprpaper wallpaper eDP-1, "$WALLPAPER"
    echo "$WALLPAPER" > ~/.cache/wallpaper
  else
    echo "Unsupported desktop environment: $XDG_SESSION_TYPE"
  fi
  dunstify -t 3000 -r 1337 "Wallpaper changed to $(basename "$WALLPAPER")"
fi
