#!/usr/bin/env bash

set -euo pipefail

BACKUP_FILE="keys_backup.txt"

backup() {
    umask 077

    tmp=$(mktemp -d)

    # GPG private keys
    gpg --export-secret-keys --armor > "$tmp/gpg-secret.asc"
    gpg --export --armor > "$tmp/gpg-public.asc"
    gpg --export-ownertrust > "$tmp/gpg-ownertrust.txt"

    # SSH keys
    cp -r ~/.ssh "$tmp/ssh"

    tar -C "$tmp" -cf - . | gpg --symmetric --cipher-algo AES256 -o "$BACKUP_FILE"

    rm -rf "$tmp"
}

restore() {
    umask 077

    tmp=$(mktemp -d)
    gpg --decrypt "$BACKUP_FILE" | tar -C "$tmp" -xf -

    # Restore GPG
    mkdir -p ~/.gnupg
    chmod 700 ~/.gnupg

    gpg --import "$tmp/gpg-public.asc"
    gpg --import "$tmp/gpg-secret.asc"
    gpg --import-ownertrust "$tmp/gpg-ownertrust.txt"

    # Restore SSH
    mkdir -p ~/.ssh
    chmod 700 ~/.ssh
    cp -r "$tmp/ssh/"* ~/.ssh/
    chmod 600 ~/.ssh/*

    rm -rf "$tmp"
}

case "${1:-}" in
    --backup)  backup ;;
    --restore) restore ;;
    *) echo "use --backup or --restore" ;;
esac

