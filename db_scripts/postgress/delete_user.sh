#!/bin/bash

# ==========================
# PostgreSQL User Deletion
# ==========================
# Usage:
#   ./postgress_delete_user.sh <DB_USER>
# Example:
#   ./postgress_delete_user.sh lms_user
# ==========================

set -euo pipefail

DB_USER=$1

if [ -z "$DB_USER" ]; then
  echo "❌ Usage: $0 <db_user>"
  exit 1
fi

echo "🧹 Removing PostgreSQL role '$DB_USER'..."

sudo -i -u postgres psql <<EOF
DO
\$do\$
BEGIN
  IF EXISTS (SELECT 1 FROM pg_roles WHERE rolname = '$DB_USER') THEN
    REASSIGN OWNED BY $DB_USER TO CURRENT_USER;
    DROP OWNED BY $DB_USER;
    DROP ROLE $DB_USER;
  END IF;
END
\$do\$;
EOF

echo "✅ PostgreSQL role '$DB_USER' removed."

