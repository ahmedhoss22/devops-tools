#!/bin/bash

set -e

# ==========================
#  Node.js Installation Script (Debian/Ubuntu)
#  Installs latest LTS from NodeSource
# ==========================

echo ">>> Updating packages..."
sudo apt update -y
sudo apt upgrade -y

echo ">>> Installing required dependencies..."
sudo apt install -y curl ca-certificates gnupg

# ==========================
# Add NodeSource LTS Repo
# ==========================
NODE_VERSION="18"   # Change to 20 or another version if you want

echo ">>> Adding NodeSource repository for Node.js $NODE_VERSION.x..."
curl -fsSL https://deb.nodesource.com/setup_${NODE_VERSION}.x | sudo -E bash -

echo ">>> Installing Node.js..."
sudo apt install -y nodejs

echo ">>> Checking installation..."
node -v
npm -v

sudo npm install -g pm2

echo ">>> Node.js installation completed successfully!"
