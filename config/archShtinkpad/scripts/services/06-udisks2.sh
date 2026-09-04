#!/usr/bin/env bash

echo "Configuring Udisks2..."

sudo systemctl enable --now udisks2

# sudo systemctl restart udisks2
# sudo systemctl disable --now udisks2
