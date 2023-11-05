#!/bin/sh

export DISPLAY=:0
export $(dbus-launch)

battery_level=$(acpi -b | grep -P -o '[0-9]+(?=%)')
discharging=$(acpi -b | grep -P -o 'Discharging')

if [ $battery_level -ge 80 ] && [ -z "$discharging" ]; then
	notify-send -u critical "Battery almost full" "Battery level is ${battery_level}%!"
fi

if [ $battery_level -le 50 ] && [ $discharging ]; then
	echo "Battery level is ${battery_level}%! $(date)" >>/home/shasherazi/battery.log
	notify-send -u critical "Charge your battery" "Battery level is ${battery_level}%!"
fi
