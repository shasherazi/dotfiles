export XDG_RUNTIME_DIR=/run/user/$(id -u)

battery_level=`acpi -b | grep -P -o '[0-9]+(?=%)'`
if [ $battery_level -ge 80 ]
then
    notify-send -u critical "Battery low" "Battery level is ${battery_level}%!"
fi
