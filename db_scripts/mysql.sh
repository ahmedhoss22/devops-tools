#!/bin/bash

# ==========================
# MySQL Database Setup
# ==========================
# Usage:
#   sudo ./mysql.sh <DB_NAME> <DB_USER> <DB_PASS> <root_pass>
# Example:
#   sudo ./mysql.sh lms_dev_user lms_user 'lms_p$$ass' 'root_password'
# ==========================


# Exit if any command fails
set -e

# Check arguments
if [ "$#" -lt 3 ]; then
  echo "Usage: $0 <db_name> <db_user> <db_pass> <root_pass>"
  exit 1
fi

DB_NAME=$1
DB_USER=$2
DB_PASS=$3

# Create database and user
mysql -u root -e "
CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
CREATE USER IF NOT EXISTS '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_PASS}';
GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO '${DB_USER}'@'localhost';
FLUSH PRIVILEGES;
"

echo "✅ Database '${DB_NAME}' and user '${DB_USER}' created successfully."
