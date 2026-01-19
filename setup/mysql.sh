#!/bin/bash
set -e

echo "=== Step 1: Update package list ==="
sudo apt-get update -y

echo "=== Step 2: Install MySQL Server ==="
sudo apt-get install -y mysql-server

echo "=== Step 3: Start MySQL service ==="
sudo systemctl start mysql

echo "=== Step 4: Enable MySQL to start on boot ==="
sudo systemctl enable mysql

echo "=== Step 5: Check MySQL service status ==="
sudo systemctl status mysql --no-pager

echo "=== MySQL installation and basic setup completed successfully ==="
