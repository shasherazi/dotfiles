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


# run this to copy from system to dotfiles
# def copyFromDestination(source, destination):
#     source = os.path.join(os.path.expanduser("~"), source)
#     destination = os.path.join(DOTFILES_PATH, destination)
#     print(f"Copying {source} to {destination}")

#     if not os.path.exists(destination):
#         os.makedirs(destination)

#     os.system(f"cp -r {source} {destination}")


destinations = [
    ".icons",
    ".themes",
    "scripts",
    ".config/alacritty",
    ".config/bspwm",
    ".config/dmenu",
    ".config/dunst",
    ".config/eww",
    ".config/hypr",
    ".config/kitty",
    ".config/lf",
    ".config/neofetch",
    ".config/nitrogen",
    ".config/nvim",
    ".config/polybar",
    ".config/picom",
    ".config/rofi",
    ".config/sxhkd",
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
    "config/hypr",
    "config/kitty",
    "config/lf",
    "config/neofetch",
    "config/nitrogen",
    "config/nvim",
    "config/polybar",
    "config/picom",
    "config/rofi",
    "config/sxhkd",
    "config/qtile",
    "config/waybar",
    "config/wofi",
    "config/zathura",
    "config/zsh/.zsh_plugins",
]


for zipped in zip(sources, destinations):
    symlink(*zipped)
