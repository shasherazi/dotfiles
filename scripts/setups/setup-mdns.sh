#!/bin/bash

# Array containing Avahi and mDNS packages
mdns_packages=("avahi" "nss-mdns")

# Function to check if a package is installed
check_package() {
  pacman -Qi "$1" &>/dev/null
  return $?
}

# Function to install required packages if not already installed
install_mdns_packages() {
  for package in "${mdns_packages[@]}"; do
    if ! check_package "$package"; then
      echo "$package is not installed. Installing $package..."
      sudo pacman -S --noconfirm "$package"
    else
      echo "$package is already installed."
    fi
  done
}

# Function to start and enable avahi-daemon service
start_avahi_service() {
  if ! systemctl is-active --quiet avahi-daemon.service; then
    echo "avahi-daemon.service is not running. Starting and enabling avahi-daemon.service..."
    sudo systemctl start avahi-daemon.service
    sudo systemctl enable avahi-daemon.service
  else
    echo "avahi-daemon.service is already running."
  fi
}

# Function to check and update /etc/nsswitch.conf for mDNS
update_nsswitch_conf() {
  NSSWITCH_FILE="/etc/nsswitch.conf"
  HOSTS_LINE="hosts: mymachines mdns_minimal [NOTFOUND=return] resolve [!UNAVAIL=return] files dns myhostname"

  # Backup the original file if not already backed up
  if [ ! -f "${NSSWITCH_FILE}.bak" ]; then
    echo "Backing up $NSSWITCH_FILE to ${NSSWITCH_FILE}.bak"
    sudo cp "$NSSWITCH_FILE" "${NSSWITCH_FILE}.bak"
  fi

  # Check if the hosts line is already correct
  if grep -q "^hosts:.*mdns_minimal.*" "$NSSWITCH_FILE"; then
    echo "nsswitch.conf already contains mdns_minimal in the hosts line."
  else
    echo "Updating hosts line in nsswitch.conf for mDNS support..."
    # Replace the hosts line (assumes only one hosts: line)
    sudo sed -i "s/^hosts:.*/$HOSTS_LINE/" "$NSSWITCH_FILE"
    echo "hosts line updated to: $HOSTS_LINE"
  fi
}

# Run the functions
install_mdns_packages
start_avahi_service
update_nsswitch_conf

echo "Avahi and mDNS setup complete. You may want to restart avahi-daemon or your network connection if you made changes."
echo "Run 'sudo systemctl restart avahi-daemon.service' to apply changes."
