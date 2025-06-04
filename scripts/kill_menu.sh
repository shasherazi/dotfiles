ps -u $USER -o pid,comm,%cpu,%mem | rofi -i -dmenu -p "Kill Process:" -config ~/.config/rofi/kill.rasi | awk '{print $1}' | xargs -r kill;
