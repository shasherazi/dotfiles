#!/usr/bin/env bash

echo "Configuring Power Profiles Daemon..."

sudo systemctl enable --now power-profiles-daemon

# sudo systemctl restart power-profiles-daemon
# sudo systemctl disable --now power-profiles-daemon
