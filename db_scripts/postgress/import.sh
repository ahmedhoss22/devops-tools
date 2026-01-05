#!/bin/bash

# ==========================
# PostgreSQL Database Import
# ==========================
# Usage:
#   ./import.sh <DB_NAME> <FILE_NAME> [DB_USER] [DB_PASS] [DB_HOST] [DB_PORT]
# Example:
#   ./import.sh my_db backup.sql postgres mypassword localhost 5432
# ==========================

# Database parameters with defaults
DB_NAME=${1:?"Error: Database name is required"}
FILE_NAME=${2:?"Error: File name is required"}
DB_USER=${3:-"postgres"}
DB_PASS=${4:-""}
DB_HOST=${5:-"localhost"}
DB_PORT=${6:-"5432"}

if [ ! -f "$FILE_NAME" ]; then
    echo "❌ Error: File '$FILE_NAME' not found."
    exit 1
fi

echo "🚀 Starting PostgreSQL import for database '${DB_NAME}' from '${FILE_NAME}'..."

# Set password via environment variable if provided
if [ -n "$DB_PASS" ]; then
    export PGPASSWORD="${DB_PASS}"
fi

# Perform import
# Using psql for .sql files
psql -U "${DB_USER}" -h "${DB_HOST}" -p "${DB_PORT}" "${DB_NAME}" < "${FILE_NAME}"

# Capture exit status
RESULT=$?

# Unset password
if [ -n "$DB_PASS" ]; then
    unset PGPASSWORD
fi

if [ $RESULT -eq 0 ]; then
    echo "✅ Import completed successfully to database '${DB_NAME}'"
else
    echo "❌ Import failed!"
    exit 1
fi
