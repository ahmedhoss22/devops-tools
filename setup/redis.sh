#!/bin/bash
set -e

echo "=== Step 1: Update package list ==="
sudo apt-get update -y

echo "=== Step 2: Install Redis Server ==="
sudo apt-get install -y redis-server

echo "=== Step 3: Start Redis service ==="
sudo systemctl start redis-server

echo "=== Step 4: Enable Redis to start on boot ==="
sudo systemctl enable redis-server

echo "=== Step 5: Check Redis service status ==="
sudo systemctl status redis-server --no-pager

echo "=== Step 6: Verify Redis installation ==="
redis-cli ping || echo "Redis CLI test failed"

echo "=== Redis installation completed successfully ==="

