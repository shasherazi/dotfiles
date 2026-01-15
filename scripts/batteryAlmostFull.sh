#!/usr/bin/env bash

battery_level=$(acpi -b | grep -P -o '[0-9]+(?=%)')
discharging=$(acpi -b | grep -P -o 'Discharging')

if [ "$battery_level" -ge 80 ] && [ -z "$discharging" ]; then
    dunstify -u critical -r 1122 "Battery almost full. Unplug the charger for longer battery life." "Battery level is ${battery_level}%!"
fi

if [ "$battery_level" -le 30 ] && [ "$discharging" ]; then
    dunstify -u critical -r 1122 "Charge your battery" "Battery level is ${battery_level}%!"
fi
