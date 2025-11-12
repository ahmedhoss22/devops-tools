#!/bin/bash

# Exit on any error
set -e

# Check if script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "❌ Please run as root (use sudo)"
  exit 1
fi

# Check argument
if [ -z "$1" ]; then
  echo "Usage: $0 <username>"
  exit 1
fi

USERNAME=$1

# Check if user already exists
if id "$USERNAME" &>/dev/null; then
  echo "⚠️  User '$USERNAME' already exists."
  exit 0
fi

# Create user with home directory and bash shell
useradd -m -s /bin/bash "$USERNAME"

# Optionally set password interactively
echo "✅ User '$USERNAME' created successfully."
echo "🔑 Set password for the user:"
passwd "$USERNAME"

# Add to sudo group (optional)
read -p "Do you want to add $USERNAME to sudo group? (y/n): " addsudo
if [[ "$addsudo" =~ ^[Yy]$ ]]; then
  usermod -aG sudo "$USERNAME"
  echo "🛠️  Added '$USERNAME' to sudo group."
fi

echo "🏠 Home directory: /home/$USERNAME"
echo "💻 Default shell: /bin/bash"
