#!/usr/bin/env bash

echo "Configuring Tailscale Daemon..."

sudo systemctl enable --now tailscaled

# sudo systemctl restart tailscaled
# sudo systemctl disable --now tailscaled
