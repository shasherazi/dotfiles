#!/usr/bin/env bash

echo "Configuring Syncthing..."

systemctl --user enable --now syncthing

# systemctl --user restart syncthing
# systemctl --user disable --now syncthing
