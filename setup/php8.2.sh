#!/usr/bin/env bash
set -e

echo "=============================="
echo " Installing PHP 8.2 + Composer"
echo "=============================="

# 1. Update system
sudo apt update -y
sudo apt install -y software-properties-common curl ca-certificates gnupg

# 2. Add Ondrej PHP repository
if ! grep -q "ondrej/php" /etc/apt/sources.list /etc/apt/sources.list.d/* 2>/dev/null; then
  sudo add-apt-repository ppa:ondrej/php -y
fi

sudo apt update -y

# 3. Install PHP 8.2 + extensions
sudo apt install -y \
php8.2 php8.2-cli php8.2-fpm php8.2-common \
php8.2-pgsql php8.2-mysql php8.2-mongodb \
php8.2-xml php8.2-curl php8.2-mbstring \
php8.2-zip php8.2-bcmath php8.2-intl php8.2-gd

# 4. Set PHP 8.2 as default
sudo update-alternatives --set php /usr/bin/php8.2 || true

# 5. Restart PHP-FPM
sudo systemctl enable php8.2-fpm
sudo systemctl restart php8.2-fpm

# 6. Install Composer (official installer)
if ! command -v composer >/dev/null 2>&1; then
  echo "Installing Composer..."
  php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
  php composer-setup.php --install-dir=/usr/local/bin --filename=composer
  rm -f composer-setup.php
else
  echo "Composer already installed"
fi

# 7. Verification
echo "=============================="
php -v
echo "------------------------------"
php -m | grep -E "pgsql|mongodb"
echo "------------------------------"
composer --version
echo "=============================="

echo "✅ PHP 8.2 + Composer installation completed"
