#!/bin/bash

# ==========================
# MongoDB Database Import
# ==========================
# Usage:
#   ./import.sh <DB_NAME> <FILE_NAME> [DB_USER] [DB_PASS] [DB_HOST] [DB_PORT]
# Example:
#   ./import.sh my_db backup_folder_or_archive [user] [pass] localhost 27017
# ==========================

# Database parameters with defaults
DB_NAME=${1:?"Error: Database name is required"}
FILE_NAME=${2:?"Error: File/Directory name is required"}
DB_USER=${3:-""}
DB_PASS=${4:-""}
DB_HOST=${5:-"localhost"}
DB_PORT=${6:-"27017"}

if [ ! -e "$FILE_NAME" ]; then
    echo "❌ Error: '$FILE_NAME' not found."
    exit 1
fi

echo "🚀 Starting MongoDB import for database '${DB_NAME}' from '${FILE_NAME}'..."

# Construct mongorestore command
CMD="mongorestore --host ${DB_HOST} --port ${DB_PORT} --db ${DB_NAME}"

# Add credentials if provided
if [ -n "$DB_USER" ]; then
    CMD="${CMD} --username ${DB_USER}"
fi

if [ -n "$DB_PASS" ]; then
    CMD="${CMD} --password ${DB_PASS}"
fi

# Determine if FILE_NAME is an archive or a directory/bson
if [[ "$FILE_NAME" == *.gz ]] || [[ "$FILE_NAME" == *.archive ]]; then
    CMD="${CMD} --archive=${FILE_NAME} --gzip"
else
    CMD="${CMD} ${FILE_NAME}"
fi

# Execute command
eval $CMD

# Capture exit status
RESULT=$?

if [ $RESULT -eq 0 ]; then
    echo "✅ Import completed successfully to database '${DB_NAME}'"
else
    echo "❌ Import failed!"
    exit 1
fi
