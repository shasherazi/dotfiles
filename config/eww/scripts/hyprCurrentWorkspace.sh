#!/bin/sh

# Function to get and output the current volume
get_volume() {
    wpctl get-volume @DEFAULT_SINK@ | awk '{print int($2 * 100)}'
}

# Output initial volume
get_volume

# Monitor for volume changes using pactl subscribe
pactl subscribe | grep --line-buffered "change" | grep --line-buffered "sink" | while read -r _; do
    get_volume
done