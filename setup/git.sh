#!/bin/bash

# Update package index
echo "Updating packages..."
sudo apt update -y

# Install Git
echo "Installing Git..."
sudo apt install -y git

# Verify installation
echo "Git version installed:"
git --version

echo "Git installation completed successfully."
