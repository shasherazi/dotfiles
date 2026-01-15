#!/usr/bin/env python

import os

DOTFILES_PATH = os.path.expanduser("~/dotfiles")


def symlink(source, destination):
    source = os.path.join(DOTFILES_PATH, source)
    destination = os.path.join(os.path.expanduser("~"), destination)

    # remove the destination if it is a folder, unlink if it is a symlink
    if os.path.isdir(destination):
        os.system(f"rm -rf {destination}")
    elif os.path.islink(destination):
        os.unlink(destination)

    print(f"Symlinking {source} to {destination}")
    os.symlink(source, destination)

destinations = [
    ".icons",
    ".themes",
    "scripts",
    ".config/alacritty",
    ".config/bspwm",
    ".config/dmenu",
    ".config/dunst",
    ".config/eww",
    ".config/gammastep",
    ".config/hypr",
    ".config/kitty",
    ".config/lf",
    ".config/mpd",
    ".config/mutt",
    ".config/nitrogen",
    ".config/nvim",
    ".config/polybar",
    ".config/picom",
    ".config/rmpc",
    ".config/rofi",
    ".config/sxhkd",
    ".config/systemd",
    ".config/tmux",
    ".config/qtile",
    ".config/waybar",
    ".config/wofi",
    ".config/zathura",
    ".zsh_plugins",
]

sources = [
    "assets/.icons",
    "assets/.themes",
    "scripts",
    "config/alacritty",
    "config/bspwm",
    "config/dmenu",
    "config/dunst",
    "config/eww",
    "config/gammastep",
    "config/hypr",
    "config/kitty",
    "config/lf",
    "config/mpd",
    "config/mutt",
    "config/nitrogen",
    "config/nvim",
    "config/polybar",
    "config/picom",
    "config/rmpc",
    "config/rofi",
    "config/sxhkd",
    "config/systemd",
    "config/tmux",
    "config/qtile",
    "config/waybar",
    "config/wofi",
    "config/zathura",
    "config/zsh/.zsh_plugins",
]


for zipped in zip(sources, destinations):
    symlink(*zipped)
