#!/usr/bin/env bash
echo "Configuring mDNS and Avahi..."

NSSWITCH_FILE="/etc/nsswitch.conf"
HOSTS_LINE="hosts: mymachines mdns_minimal [NOTFOUND=return] resolve [!UNAVAIL=return] files dns myhostname"

if ! grep -q "^hosts:.*mdns_minimal.*" "$NSSWITCH_FILE"; then
  echo "Updating hosts line in nsswitch.conf for mDNS support..."
  sudo sed -i "s/^hosts:.*/$HOSTS_LINE/" "$NSSWITCH_FILE"
fi

sudo systemctl enable --now avahi-daemon

# sudo systemctl restart avahi-daemon
# sudo systemctl disable --now avahi-daemon
