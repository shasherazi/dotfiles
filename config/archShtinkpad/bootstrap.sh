#!/usr/bin/env bash

set -euo pipefail # Enable strict mode for better error handling

# Ensure we are running from the directory where bootstrap.sh lives
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
cd "$DIR"

echo "Starting Arch Linux setup for shtinkpad..."

# Make scripts executable just in case
chmod +x scripts/*.sh

# Run scripts in alphabetical/numerical order
./scripts/00-yay.sh
./scripts/01-packages.sh
./scripts/02-symlinks.sh
# ./scripts/03-services.sh

echo "Bootstrap complete!"
