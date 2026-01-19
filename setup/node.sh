#!/bin/bash

set -e

# ==========================
#  Node.js Installation Script (Debian/Ubuntu)
#  Installs latest version from NodeSource
# ==========================

echo ">>> Updating packages..."
sudo apt update -y

echo ">>> Installing required dependencies..."
sudo apt install -y curl ca-certificates gnupg

# ==========================
# Add NodeSource Repository
# ==========================
# Version 25 is the current latest release
NODE_MAJOR=25

echo ">>> Adding NodeSource repository for Node.js $NODE_MAJOR.x..."
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg

echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list

echo ">>> Updating package list again..."
sudo apt update -y

echo ">>> Installing Node.js..."
sudo apt install -y nodejs

echo ">>> Checking installation..."
node -v || echo "Node installation failed"
npm -v || echo "NPM installation failed"

echo ">>> Installing PM2 globally..."
sudo npm install -g pm2

echo ">>> Node.js installation completed successfully!"
