#!/bin/bash

# ==========================
# MongoDB Database Setup
# ==========================
# Usage:
#   sudo ./mongoDB.sh <DB_NAME> <DB_USER> <DB_PASS>
# Example:
#   sudo ./mongoDB.sh lms_dev_user lms_user 'lms_p$$ass'
# ==========================
# Usage:
#   sudo ./mongoDB.sh <DB_NAME> <DB_USER> <DB_PASS>
# Example:
#   sudo ./mongoDB.sh lms_dev_user lms_user 'lms_p$$ass'
# ==========================

DB_NAME=$1
DB_USER=$2
DB_PASS=$3

if [ -z "$DB_NAME" ] || [ -z "$DB_USER" ] || [ -z "$DB_PASS" ]; then
  echo "❌ Usage: $0 <database_name> <username> <password>"
  exit 1
fi

echo "🚀 Creating MongoDB database and user..."
mongosh <<EOF
use $DB_NAME
db.createUser({
  user: "$DB_USER",
  pwd: "$DB_PASS",
  roles: [ { role: "readWrite", db: "$DB_NAME" } ]
})
EOF

if [ $? -eq 0 ]; then
  echo "✅ MongoDB user '$DB_USER' created for database '$DB_NAME'"
else
  echo "❌ Failed to create MongoDB user"
  exit 1
fi
