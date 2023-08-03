#!/usr/bin/env python3

import json
import os
import sys

ALLOWED_CATEGORIES = ["base", "xorg", "bspwm", "wayland", "hyprland"]


def install_packages_from_json(category):
    with open(category) as f:
        data = json.load(f)
        packages = ""
        print("Packages to install: ")
        for package in data:
            print(package["name"], end=" ", flush=True)
            packages += package["name"] + " "
    print()
    os.system("yay -Syu --needed --noconfirm " + packages)


if "-h" in sys.argv or "--help" in sys.argv:
    print(
        """
    Usage: packagesInstaller.py -c, --category <category>

    -c, --category <category>   Category of packages to install
    -h, --help                  Show this help message

    Categories:
        -base     install packages that are required for every setup like fav apps etc
        -xorg     install packages that are required for xorg setup
        -bspwm    install packages that are required for bspwm setup
        -wayland  install packages that are required for wayland setup
        -hyprland install packages that are required for hyprland setup
    """
    )
    sys.exit(0)

if "-c" in sys.argv or "--category" in sys.argv:
    if "-c" in sys.argv:
        category = sys.argv[sys.argv.index("-c") + 1]
    else:
        category = sys.argv[sys.argv.index("--category") + 1]

    if category not in ALLOWED_CATEGORIES:
        print("Invalid category")
        sys.exit(1)
    else:
        print("Installing packages for category: " + category)
        if category == "base":
            install_packages_from_json("../installPackages/packages.json")
        elif category == "xorg":
            install_packages_from_json(
                "../installPackages/installXOnlyPackages/packagesX.json"
            )
        elif category == "bspwm":
            install_packages_from_json(
                "../installPackages/installXOnlyPackages/packagesbspwm.json"
            )
        elif category == "wayland":
            install_packages_from_json(
                "../installPackages/installWaylandOnlyPackages/packagesWayland.json"
            )
        elif category == "hyprland":
            install_packages_from_json(
                "../installPackages/installWaylandOnlyPackages/packagesHyprland.json"
            )
