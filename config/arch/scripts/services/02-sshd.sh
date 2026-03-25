#!/usr/bin/env bash

echo "Configuring OpenSSH Daemon..."

# 1. Apply SSH hardening settings via a drop-in configuration file
SSHD_CONF_DIR="/etc/ssh/sshd_config.d"
CUSTOM_CONF="$SSHD_CONF_DIR/99-custom.conf"

sudo mkdir -p "$SSHD_CONF_DIR"

echo "Applying hardened SSH settings..."
sudo tee "$CUSTOM_CONF" >/dev/null <<EOF
# Custom SSH Hardening (Migrated from NixOS)
PermitRootLogin no
PasswordAuthentication no
KbdInteractiveAuthentication no
X11Forwarding no
EOF

# Ensure correct permissions on the drop-in file
sudo chmod 644 "$CUSTOM_CONF"

# 2. Add the authorized key for the current user
SSH_DIR="$HOME/.ssh"
AUTH_KEYS="$SSH_DIR/authorized_keys"
PUB_KEY="ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICYif6UohbY1eCjpso9MS6FsEI7O9/EXWtid0bBizAyn hassanrandomz@gmail.com"

echo "Setting up authorized keys..."
mkdir -p "$SSH_DIR"
chmod 700 "$SSH_DIR" # SSH strictly requires 700 on the directory

# Idempotent check: only add the key if it's not already in the file
if ! grep -qF "$PUB_KEY" "$AUTH_KEYS" 2>/dev/null; then
  echo "$PUB_KEY" >>"$AUTH_KEYS"
fi

chmod 600 "$AUTH_KEYS" # SSH strictly requires 600 on the keys file

# 3. Enable the SSH daemon
echo "Enabling sshd..."
sudo systemctl enable --now sshd

# Restart sshd to ensure it picks up the new 99-custom.conf if it was already running
sudo systemctl restart sshd

# sudo systemctl disable --now sshd
