#!/usr/bin/env bash

echo "Configuring Bluetooth..."

sudo modprobe btusb
sudo systemctl enable --now bluetooth

# sudo systemctl restart bluetooth
# sudo systemctl disable --now bluetooth
