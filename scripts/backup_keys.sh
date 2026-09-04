#!/usr/bin/env bash
set -euo pipefail

require() {
  command -v "$1" >/dev/null 2>&1 || {
    echo "$1 not installed"
    exit 1
  }
}

usage() {
  cat <<EOF
Usage: $(basename "$0") <command> -f <file>

Commands:
  --backup   Backup GPG and SSH keys to an encrypted file
  --restore  Restore GPG and SSH keys from an encrypted file

Options:
  -f <file>  Path to the backup file (required)
  -h         Show this help message

Examples:
  $(basename "$0") --backup -f ~/keys_backup.enc
  $(basename "$0") --restore -f ~/keys_backup.enc
EOF
  exit 0
}

backup() {
  require gpg
  umask 077

  tmp=$(mktemp -d)

  gpg --export-secret-keys --armor >"$tmp/gpg-secret.asc"
  gpg --export --armor >"$tmp/gpg-public.asc"
  gpg --export-ownertrust >"$tmp/gpg-ownertrust.txt"

  if [ -d "$HOME/.ssh" ]; then
    cp -r "$HOME/.ssh" "$tmp/ssh"
  fi

  tar -C "$tmp" -cf - . |
    gpg --symmetric --cipher-algo AES256 \
      --pinentry-mode loopback -o "$BACKUP_FILE"

  rm -rf "$tmp"
  echo "Backup saved to $BACKUP_FILE"
}

restore() {
  require gpg
  umask 077

  if [ ! -f "$BACKUP_FILE" ]; then
    echo "Error: file '$BACKUP_FILE' not found"
    exit 1
  fi

  tmp=$(mktemp -d)

  gpg --decrypt --pinentry-mode loopback "$BACKUP_FILE" |
    tar -C "$tmp" -xf -

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
  echo "Restore complete from $BACKUP_FILE"
}

# Show help if no args
if [ $# -eq 0 ]; then
  usage
fi

COMMAND=""
BACKUP_FILE=""

# Parse args
while [ $# -gt 0 ]; do
  case "$1" in
  --backup)
    COMMAND="backup"
    shift
    ;;
  --restore)
    COMMAND="restore"
    shift
    ;;
  -f)
    [ -n "${2:-}" ] || {
      echo "Error: -f requires a file path"
      exit 1
    }
    BACKUP_FILE="$2"
    shift 2
    ;;
  -h | --help) usage ;;
  *)
    echo "Unknown option: $1"
    usage
    ;;
  esac
done

if [ -z "$COMMAND" ]; then
  echo "Error: specify --backup or --restore"
  exit 1
fi

if [ -z "$BACKUP_FILE" ]; then
  echo "Error: -f <file> is required"
  exit 1
fi

"$COMMAND"
