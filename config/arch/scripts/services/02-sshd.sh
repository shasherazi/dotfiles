#!/usr/bin/env bash

echo "Configuring OpenSSH Daemon..."

sudo systemctl enable --now sshd

# sudo systemctl restart sshd
# sudo systemctl disable --now sshd
