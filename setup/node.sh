#!/bin/bash
set -e

echo "=== Step 1: Install dependencies gnupg and curl ==="
sudo apt-get update
sudo apt-get install -y gnupg curl

echo "=== Step 2: Import MongoDB GPG key ==="
curl -fsSL https://www.mongodb.org/static/pgp/server-8.0.asc | \
   sudo gpg -o /usr/share/keyrings/mongodb-server-8.0.gpg --dearmor

echo "=== Step 3: Add MongoDB APT repository ==="
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-8.0.gpg ] https://repo.mongodb.org/apt/ubuntu noble/mongodb-org/8.2 multiverse" \
   | sudo tee /etc/apt/sources.list.d/mongodb-org-8.2.list

echo "=== Step 4: Update package list ==="
sudo apt-get update

echo "=== Step 5: Install MongoDB ==="
sudo apt-get install -y mongodb-org

echo "=== Step 6: Start MongoDB service ==="
sudo systemctl start mongod

echo "=== Step 7: Reload systemd daemon ==="
sudo systemctl daemon-reload

echo "=== Step 8: Check MongoDB service status ==="
sudo systemctl status mongod --no-pager

echo "=== Step 9: Enable MongoDB to start on boot ==="
sudo systemctl enable mongod

echo "=== Step 10: Restart MongoDB service ==="
sudo systemctl restart mongod

echo "=== MongoDB installation completed successfully ==="
