#!/usr/bin/env bash
set -euo pipefail

BACKUP_FILE="keys_backup.txt"

require() {
    command -v "$1" >/dev/null 2>&1 || { echo "$1 not installed"; exit 1; }
}

backup() {
    require gpg
    umask 077

    tmp=$(mktemp -d)

    gpg --export-secret-keys --armor > "$tmp/gpg-secret.asc"
    gpg --export --armor > "$tmp/gpg-public.asc"
    gpg --export-ownertrust > "$tmp/gpg-ownertrust.txt"

    if [ -d "$HOME/.ssh" ]; then
        cp -r "$HOME/.ssh" "$tmp/ssh"
    fi

    tar -C "$tmp" -cf - . \
        | gpg --symmetric --cipher-algo AES256 --pinentry-mode loopback -o "$BACKUP_FILE"

    rm -rf "$tmp"
}

restore() {
    require gpg
    umask 077

    tmp=$(mktemp -d)

    gpg --decrypt --pinentry-mode loopback "$BACKUP_FILE" \
        | tar -C "$tmp" -xf -

    mkdir -p "$HOME/.gnupg"
    chmod 700 "$HOME/.gnupg"

    gpg --import "$tmp/gpg-public.asc"
    gpg --import "$tmp/gpg-secret.asc"
    gpg --import-ownertrust "$tmp/gpg-ownertrust.txt"

    if [ -d "$tmp/ssh" ]; then
        mkdir -p "$HOME/.ssh"
        chmod 700 "$HOME/.ssh"
        cp -r "$tmp/ssh/"* "$HOME/.ssh/" || true
        chmod 600 "$HOME/.ssh/"* || true
    fi

    rm -rf "$tmp"
}

case "${1:-}" in
    --backup) backup ;;
    --restore) restore ;;
    *) echo "use --backup or --restore" ;;
esac
