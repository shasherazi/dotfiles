#!/bin/sh

cat ~/scripts/launchers/bookmarks.csv | dmenu -l 10 -i -p "Bookmarks" | awk '{print $1}' | tr -d '\n' | xclip -selection clipboard
