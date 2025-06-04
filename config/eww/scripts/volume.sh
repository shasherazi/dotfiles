#!/bin/sh

while true; do
    # Use wpctl get-volume with proper parsing
    volume=$(wpctl get-volume @DEFAULT_SINK@ | awk '{print $2 * 100}')

    # Ensure the volume is an integer
    echo "$volume" | awk '{print int($1)}'
    sleep 1
done
