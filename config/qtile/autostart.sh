#!/bin/sh

nitrogen --restore
sh ~/scripts/inputDevicesConfig.sh

picom & disown # --experimental-backends --vsync should prevent screen tearing on most setups if needed
# Start welcome
eos-welcome & disown
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 & disown # start polkit agent from GNOME
