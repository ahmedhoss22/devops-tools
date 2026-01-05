#!/bin/bash

# ==========================
# MongoDB Database Backup
# ==========================
# Usage:
#   ./mongo_backup.sh <DB_NAME> <DB_USER> <DB_PASS> <FILENAME>
# Example:
#   ./mongo_backup.sh lms_dev_user lms_user 'lms_p$$ass' backup_20240101
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

# Create backup directory if it doesn't exist
BACKUP_DIR="${FILENAME}"
if [ -d "${BACKUP_DIR}" ]; then
  echo "⚠️  Backup directory already exists: ${BACKUP_DIR}"
  read -p "Do you want to overwrite it? (y/N): " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "❌ Backup cancelled"
    exit 1
  fi
  rm -rf "${BACKUP_DIR}"
fi

echo "🚀 Starting MongoDB backup for database '${DB_NAME}'..."

# Perform backup using mongodump
mongodump --host localhost \
          --db "${DB_NAME}" \
          --username "${DB_USER}" \
          --password "${DB_PASS}" \
          --authenticationDatabase "admin" \
          --out "${BACKUP_DIR}"

if [ $? -eq 0 ]; then
  echo "✅ Backup completed successfully: ${BACKUP_DIR}"
  echo "📦 Backup size: $(du -sh "${BACKUP_DIR}" | cut -f1)"
  echo "📁 Backup location: ${BACKUP_DIR}/${DB_NAME}"
else
  echo "❌ Backup failed!"
  exit 1
fi

