#!/usr/bin/env bash
set -e

if command -v yay &>/dev/null; then
  echo "yay is already installed, skipping..."
  exit 0
fi

echo "Installing yay-bin..."
sudo pacman -S --needed --noconfirm git base-devel

# Use /tmp to avoid cluttering your home directory
cd /tmp
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si --noconfirm

# Cleanup
rm -rf /tmp/yay-bin
