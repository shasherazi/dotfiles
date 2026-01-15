#!/bin/bash

# Array containing Bluetooth packages
pipewire_packages=("pipewire" "pipewire-audio" "pipewire-pulse" "pipewire-alsa" "wireplumber")

# Function to check if a package is installed
check_package() {
  pacman -Qi "$1" &>/dev/null
  return $?
}

# Loop through the package array and install if not already installed
install_packages() {
  for package in "${pipewire_packages[@]}"; do
    if ! check_package "$package"; then
      echo "$package is not installed. Installing $package..."
      sudo pacman -S --noconfirm "$package"
    else
      echo "$package is already installed."
    fi
  done
}

install_packages
