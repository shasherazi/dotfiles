#!/bin/sh

set_wallpaper() {
  if [ -n "$WALLPAPER" ]; then
    if [ "$XDG_SESSION_TYPE" = "x11" ]; then
      nitrogen --set-zoom-fill "$WALLPAPER"
    elif [ "$XDG_SESSION_TYPE" = "wayland" ]; then
      hyprctl hyprpaper wallpaper eDP-1, "$WALLPAPER"
      echo "$WALLPAPER" >~/.cache/wallpaper
    else
      echo "Unsupported desktop environment: $XDG_SESSION_TYPE"
    fi
    dunstify -t 3000 -r 1337 "Wallpaper changed to $(basename "$WALLPAPER")"
  fi
}

if [ -r ~/.cache/wallpaper ]; then
  WALLPAPER=$(cat ~/.cache/wallpaper)
else
  WALLPAPER="/home/shasherazi/wallpapers/blue-landscape.png"
fi

OPTIONS="DELETE $(basename "$WALLPAPER")
RENAME $(basename "$WALLPAPER")"

ACTION=$(printf "%s" "$OPTIONS" | rofi -dmenu)

case $ACTION in
"DELETE $(basename "$WALLPAPER")")
  rm -f "$WALLPAPER"
  rm -f ~/.cache/wallpaper
  dunstify -t 3000 -r 1337 "Wallpaper deleted: $(basename "$WALLPAPER")"
  ;;
"RENAME $(basename "$WALLPAPER")")
  NEW_NAME=$(rofi -dmenu -p "New name for $(basename "$WALLPAPER")")
  if [ -n "$NEW_NAME" ]; then
    NEW_PATH="$(dirname "$WALLPAPER")/$NEW_NAME"
    mv "$WALLPAPER" "$NEW_PATH"
    WALLPAPER="$NEW_PATH"
    set_wallpaper
  fi
  ;;
*)
  exit 0
  ;;
esac
