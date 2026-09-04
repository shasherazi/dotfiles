#!/usr/bin/env bash

echo "Configuring Pipewire Audio..."

systemctl --user enable --now pipewire wireplumber pipewire-pulse

# systemctl --user restart pipewire wireplumber pipewire-pulse
# systemctl --user disable --now pipewire wireplumber pipewire-pulse
