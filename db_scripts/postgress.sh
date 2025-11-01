#!/bin/bash

# ==========================
# PostgreSQL Database Setup
# ==========================
# Usage:
#   sudo ./create_pg_db_user.sh <DB_NAME> <DB_USER> <DB_PASS>
# Example:
#   sudo ./create_pg_db_user.sh lms_dev_user lms_user 'lms_p$$ass'
# ==========================

DB_NAME=$1
DB_USER=$2
DB_PASS=$3

if [ -z "$DB_NAME" ] || [ -z "$DB_USER" ] || [ -z "$DB_PASS" ]; then
  echo "❌ Usage: $0 <DB_NAME> <DB_USER> <DB_PASS>"
  exit 1
fi

echo "🚀 Creating PostgreSQL database and user..."
sudo -i -u postgres psql <<EOF
-- Create database
CREATE DATABASE $DB_NAME;

-- Create user with password
CREATE USER $DB_USER WITH PASSWORD '$DB_PASS';

-- Grant privileges on the database
GRANT ALL PRIVILEGES ON DATABASE $DB_NAME TO $DB_USER;

-- Connect to the new database
\c $DB_NAME

-- Grant schema privileges
GRANT ALL PRIVILEGES ON SCHEMA public TO $DB_USER;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO $DB_USER;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO $DB_USER;
EOF

echo "✅ Database '$DB_NAME' and user '$DB_USER' created successfully!"
