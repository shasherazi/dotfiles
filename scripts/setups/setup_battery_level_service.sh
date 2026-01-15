#!/bin/sh
set -euo pipefail

SERVICE_DIR="$HOME/.config/systemd/user"
SERVICE_FILE="$SERVICE_DIR/battery-check.service"
TIMER_FILE="$SERVICE_DIR/battery-check.timer"
SCRIPT_PATH="$HOME/scripts/batteryAlmostFull.sh"

ask_overwrite() {
  local file="$1"
  while true; do
    read -rp "File '$file' exists. Overwrite? [y/N] " yn
    case "${yn,,}" in
      y|yes) return 0 ;;
      n|no|"") return 1 ;;
      *) echo "Please answer yes or no." ;;
    esac
  done
}

# Ensure script to be executed exists
if [ ! -x "$SCRIPT_PATH" ]; then
  echo "Error: '$SCRIPT_PATH' not found or not executable." >&2
  exit 1
fi

mkdir -p "$SERVICE_DIR"

changed=false

# Service unit
if [ -e "$SERVICE_FILE" ]; then
  if ask_overwrite "$SERVICE_FILE"; then
    overwrite_srv=true
  else
    overwrite_srv=false
  fi
else
  overwrite_srv=true
fi

if $overwrite_srv; then
  cat > "$SERVICE_FILE" <<EOF
[Unit]
Description=Battery Level Check

[Service]
Type=oneshot
ExecStart=$SCRIPT_PATH
EOF
  echo "Wrote $SERVICE_FILE"
  changed=true
else
  echo "Skipped $SERVICE_FILE"
fi

# Timer unit
if [ -e "$TIMER_FILE" ]; then
  if ask_overwrite "$TIMER_FILE"; then
    overwrite_timer=true
  else
    overwrite_timer=false
  fi
else
  overwrite_timer=true
fi

if $overwrite_timer; then
  cat > "$TIMER_FILE" <<EOF
[Unit]
Description=Run battery check every 5 minutes

[Timer]
OnCalendar=*:0/5
Persistent=true

[Install]
WantedBy=timers.target
EOF
  echo "Wrote $TIMER_FILE"
  changed=true
else
  echo "Skipped $TIMER_FILE"
fi

if ! $changed; then
  echo "No changes made, exiting."
  exit 0
fi

# Reload, enable and start
systemctl --user daemon-reload
systemctl --user enable --now battery-check.timer

echo "Done: battery-check.timer enabled & started."
