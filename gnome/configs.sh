# gnome
gsettings set org.gnome.desktop.interface color-scheme prefer-dark
gsettings set org.gnome.desktop.interface cursor-theme Posy_Cursor
gsettings set org.gnome.desktop.interface gtk-theme WhiteSur-Dark
gsettings set org.gnome.desktop.interface enable-hot-corners false
gsettings set org.gnome.desktop.interface clock-show-weekday true
gsettings set org.gnome.desktop.input-sources xkb-options "['caps:swapescape']"
gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true
gsettings set org.gnome.settings-daemon.plugins.color night-light-temperature 3700
gsettings set org.gnome.desktop.interface show-battery-percentage true

# plank
dconf write /net/launchpad/plank/docks/dock1/theme "'mcOS-BS-iMacM1-Black'"
dconf write /net/launchpad/plank/docks/dock1/unhide-delay 0
dconf write /net/launchpad/plank/docks/dock1/zoom-enabled true
dconf write /net/launchpad/plank/docks/dock1/zoom-percent 169
dconf write /net/launchpad/plank/docks/dock1/icon-size 48
dconf write /net/launchpad/plank/docks/dock1/hide-mode "'dodge-active'"
dconf write /net/launchpad/plank/docks/dock1/hide-delay 200
