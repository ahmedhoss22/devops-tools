#!/bin/bash

set -e

# ======================================
# Full Server Setup Script (Debian)
# Installs: Node.js, Nginx, Certbot
# ======================================

NODE_VERSION="18"  # Change to 20 or other LTS if needed

echo ">>> Updating system packages..."
sudo apt update -y
sudo apt upgrade -y

echo ">>> Installing required dependencies..."
sudo apt install -y curl ca-certificates gnupg lsb-release software-properties-common

# ======================================
# Install Node.js (NodeSource)
# ======================================
echo ">>> Adding NodeSource repo for Node.js $NODE_VERSION..."
curl -fsSL https://deb.nodesource.com/setup_${NODE_VERSION}.x | sudo -E bash -

echo ">>> Installing Node.js..."
sudo apt install -y nodejs

echo ">>> Node.js Installed:"
node -v
npm -v

# ======================================
# Install Nginx
# ======================================
echo ">>> Installing Nginx..."
sudo apt install -y nginx

echo ">>> Enabling and starting Nginx..."
sudo systemctl enable nginx
sudo systemctl start nginx
sudo systemctl status nginx --no-pager

# ======================================
# Install Certbot (for HTTPS)
# ======================================
echo ">>> Installing Certbot + Nginx plugin..."
sudo apt install -y certbot python3-certbot-nginx

echo ">>> Certbot installed!"

# ======================================
# Final Output
# ======================================
echo "======================================"
echo " ✔ Node.js Installed"
echo " ✔ Nginx Installed & Running"
echo " ✔ Certbot Installed"
echo "======================================"
echo "To issue an SSL certificate, run:"
echo "  sudo certbot --nginx -d yourdomain.com -d www.yourdomain.com"
echo "======================================"
