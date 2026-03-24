#!/usr/bin/env bash

set -euo pipefail # Enable strict mode for better error handling

# Define where your text files live
PKG_DIR="pkgs"

if [ ! -d "$PKG_DIR" ]; then
  echo "Error: Directory '$PKG_DIR' not found!"
  exit 1
fi

# Array to hold all parsed packages
PKGS=()

# Loop through every .txt file in the directory
for list in "$PKG_DIR"/*.txt; do
  echo "Parsing $list..."
  while IFS= read -r line || [ -n "$line" ]; do
    # 1. Strip comments (everything after #)
    clean_line="${line%%#*}"

    # 2. Trim leading and trailing whitespace
    clean_line="$(echo -e "$clean_line" | tr -d '[:space:]')"

    # 3. If line is not empty, add it to the array
    if [ -n "$clean_line" ]; then
      PKGS+=("$clean_line")
    fi
  done <"$list"
done

# Exit if no packages were found
if [ ${#PKGS[@]} -eq 0 ]; then
  echo "No packages found to install."
  exit 0
fi

echo "Installing ${#PKGS[@]} packages using yay..."

# yay handles both official and AUR packages seamlessly
# --needed prevents reinstalling packages that are already up-to-date
yay -S --needed --noconfirm "${PKGS[@]}"

echo "Package installation complete!"
