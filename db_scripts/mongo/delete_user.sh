#!/bin/bash

# ==========================
# MongoDB User Deletion
# ==========================
# Usage:
#   ./mongoDB_delete_user.sh <DB_NAME> <DB_USER>
# Example:
#   ./mongoDB_delete_user.sh lms_dev_user lms_user
# ==========================

set -e

DB_NAME=$1
DB_USER=$2

if [ -z "$DB_NAME" ] || [ -z "$DB_USER" ]; then
  echo "❌ Usage: $0 <database_name> <username>"
  exit 1
fi

echo "🧹 Removing MongoDB user '$DB_USER' from database '$DB_NAME'..."

if mongosh <<EOF >/dev/null
use $DB_NAME
db.dropUser("$DB_USER")
EOF
then
  echo "✅ User '$DB_USER' removed from MongoDB database '$DB_NAME'."
else
  echo "❌ Failed to remove MongoDB user '$DB_USER' from '$DB_NAME'."
  exit 1
fi

