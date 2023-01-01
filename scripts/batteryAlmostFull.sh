export XDG_RUNTIME_DIR=/run/user/$(id -u)

battery_level=`acpi -b | grep -P -o '[0-9]+(?=%)'`
discharging=`acpi -b | grep -P -o 'Discharging'`

if [ $battery_level -ge 80 ] && [ -z "$discharging" ]
then
    notify-send -u critical "Battery almost full" "Battery level is ${battery_level}%!"
fi

if [ $battery_level -le 50 ] && [ $discharging ]
then
  notify-send -u critical "Charge your battery" "Battery level is ${battery_level}%!"
fi
