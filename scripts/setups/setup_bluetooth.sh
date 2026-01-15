#!/bin/bash

# Array containing Bluetooth packages
bt_packages=("bluez" "bluez-utils" "bluetui")

# Function to check if a package is installed
check_package() {
  pacman -Qi "$1" &>/dev/null
  return $?
}

# Function to check if the btusb kernel module is loaded
check_btusb_module() {
  lsmod | grep -q "^btusb" &>/dev/null
  return $?
}

# Function to load the btusb module if it's not loaded
load_btusb_module() {
  if ! check_btusb_module; then
    echo "btusb module is not loaded. Loading the btusb module..."
    sudo modprobe btusb
  else
    echo "btusb module is already loaded."
  fi
}

# Function to check if bluetooth.service is running and enable/start it if not
start_bluetooth_service() {
  if ! systemctl is-active --quiet bluetooth.service; then
    echo "bluetooth.service is not running. Starting and enabling bluetooth.service..."
    sudo systemctl start bluetooth.service
    sudo systemctl enable bluetooth.service
  else
    echo "bluetooth.service is already running."
  fi
}

# Loop through the package array and install if not already installed
install_packages() {
  for package in "${bt_packages[@]}"; do
    if ! check_package "$package"; then
      echo "$package is not installed. Installing $package..."
      sudo pacman -S --noconfirm "$package"
    else
      echo "$package is already installed."
    fi
  done
}

# Run the functions
install_packages
load_btusb_module
start_bluetooth_service
