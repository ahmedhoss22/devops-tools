#!/bin/bash
set -e

echo "=== Step 1: Update package list ==="
sudo apt update -y

echo "=== Step 2: Install PostgreSQL and contrib package ==="
sudo apt install -y postgresql postgresql-contrib

echo "=== Step 3: Start PostgreSQL service ==="
sudo systemctl start postgresql

echo "=== Step 4: Enable PostgreSQL to start on boot ==="
sudo systemctl enable postgresql

echo "=== Step 5: Check PostgreSQL service status ==="
sudo systemctl status postgresql --no-pager

echo "=== Step 6: Switch to postgres user and create a test user and database ==="
sudo -i -u postgres psql -c "CREATE USER testuser WITH PASSWORD 'testpass';"
sudo -i -u postgres psql -c "CREATE DATABASE testdb OWNER testuser;"

echo "=== PostgreSQL installation and basic setup completed successfully ==="
