from libqtile import hook
import subprocess
import os


@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser("~/.config/qtile/autostart.sh")
    subprocess.call([home])


@hook.subscribe.restart
def restart():
    home = os.path.expanduser("~/.config/qtile/restart.sh")
    subprocess.call([home])
