#!/bin/bash

# ==========================
# PostgreSQL Database Backup
# ==========================
# Usage:
#   ./postgres_backup.sh <DB_NAME> <DB_USER> <DB_PASS> <FILENAME>
# Example:
#   ./postgres_backup.sh lms_dev_user lms_user 'lms_p$$ass' backup_20240101.sql
# ==========================

# Exit if any command fails
set -e

# Check arguments
if [ "$#" -lt 4 ]; then
  echo "❌ Usage: $0 <db_name> <db_user> <db_pass> <filename>"
  exit 1
fi

DB_NAME=$1
DB_USER=$2
DB_PASS=$3
FILENAME=$4

# Validate filename
if [ -z "$FILENAME" ]; then
  echo "❌ Filename cannot be empty"
  exit 1
fi

# Add .sql extension if not present
if [[ ! "$FILENAME" =~ \.sql$ ]]; then
  FILENAME="${FILENAME}.sql"
fi

echo "🚀 Starting PostgreSQL backup for database '${DB_NAME}'..."

# Set password via environment variable to avoid prompt
export PGPASSWORD="${DB_PASS}"

# Perform backup
pg_dump -U "${DB_USER}" -h localhost "${DB_NAME}" > "${FILENAME}"

# Unset password for security
unset PGPASSWORD

if [ $? -eq 0 ]; then
  echo "✅ Backup completed successfully: ${FILENAME}"
  echo "📦 Backup size: $(du -h "${FILENAME}" | cut -f1)"
else
  echo "❌ Backup failed!"
  exit 1
fi

