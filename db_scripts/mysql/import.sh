#!/bin/bash

# ==========================
# MySQL Database Import
# ==========================
# Usage:
#   ./import.sh <DB_NAME> <FILE_NAME> [DB_USER] [DB_PASS] [DB_HOST] [DB_PORT]
# Example:
#   ./import.sh my_db backup.sql root mypassword localhost 3306
# ==========================

# Database parameters with defaults
DB_NAME=${1:?"Error: Database name is required"}
FILE_NAME=${2:?"Error: File name is required"}
DB_USER=${3:-"root"}
DB_PASS=${4:-""}
DB_HOST=${5:-"localhost"}
DB_PORT=${6:-"3306"}

if [ ! -f "$FILE_NAME" ]; then
    echo "❌ Error: File '$FILE_NAME' not found."
    exit 1
fi

echo "🚀 Starting MySQL import for database '${DB_NAME}' from '${FILE_NAME}'..."

# Construct connection parameters
CONN_PARAMS="-u ${DB_USER} -h ${DB_HOST} -P ${DB_PORT}"

# Add password if provided (note: -p without space)
if [ -n "$DB_PASS" ]; then
    # Using MYSQL_PWD is often safer than -p in command line to avoid warnings
    export MYSQL_PWD="${DB_PASS}"
fi

# Perform import
mysql ${CONN_PARAMS} "${DB_NAME}" < "${FILE_NAME}"

# Capture exit status
RESULT=$?

# Unset password
if [ -n "$DB_PASS" ]; then
    unset MYSQL_PWD
fi

if [ $RESULT -eq 0 ]; then
    echo "✅ Import completed successfully to database '${DB_NAME}'"
else
    echo "❌ Import failed!"
    exit 1
fi
