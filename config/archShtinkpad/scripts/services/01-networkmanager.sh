#!/usr/bin/env bash

echo "Configuring NetworkManager..."

sudo systemctl enable --now NetworkManager

# sudo systemctl restart NetworkManager
# sudo systemctl disable --now NetworkManager
