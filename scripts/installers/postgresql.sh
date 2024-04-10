# check if postgresql is installed, install if not
if ! command -v psql &>/dev/null; then
	echo "PostgreSQL not found, installing..."
	sudo pacman -S postgresql --noconfirm --needed
else
	echo "PostgreSQL found, skipping..."
  exit 0
fi

# initialize database cluster as postgres user
echo "Initializing database cluster..."
sudo -u postgres initdb -D /var/lib/postgres/data

# start and enable postgresql
echo "Starting and enabling postgresql service..."
sudo systemctl enable --now postgresql.service

# create user
echo "Creating user interactively, you can choose the username as the same as your user..."
sudo -u postgres createuser --interactive
