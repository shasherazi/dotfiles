#!/usr/bin/env bash

echo "Configuring PostgreSQL..."

# Initialize database cluster if not already done
if [ ! -d "/var/lib/postgres/data/base" ]; then
  echo "Initializing database cluster..."
  sudo -u postgres initdb -D /var/lib/postgres/data
fi

sudo systemctl enable --now postgresql.service

# sudo systemctl restart postgresql.service
# sudo systemctl disable --now postgresql.service
