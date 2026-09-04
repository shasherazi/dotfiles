#!/usr/bin/env bash

echo "Configuring Custom Battery Timer..."

SERVICE_DIR="$HOME/.config/systemd/user"
SERVICE_FILE="$SERVICE_DIR/battery-check.service"
TIMER_FILE="$SERVICE_DIR/battery-check.timer"

# Make sure this points to where you actually keep the script in your new setup
SCRIPT_PATH="$HOME/scripts/batteryAlmostFull.sh"

mkdir -p "$SERVICE_DIR"

cat >"$SERVICE_FILE" <<EOF
[Unit]
Description=Battery Level Check

[Service]
Type=oneshot
ExecStart=$SCRIPT_PATH
EOF

cat >"$TIMER_FILE" <<EOF
[Unit]
Description=Run battery check every 5 minutes

[Timer]
OnCalendar=*:0/5
Persistent=true

[Install]
WantedBy=timers.target
EOF

systemctl --user daemon-reload

systemctl --user enable --now battery-check.timer

# systemctl --user restart battery-check.timer
# systemctl --user disable --now battery-check.timer
