#!/bin/bash

# ==========================
# MySQL User Deletion
# ==========================
# Usage:
#   ./mysql_delete_user.sh <DB_USER> [HOST]
# Example:
#   ./mysql_delete_user.sh lms_user localhost
# ==========================

set -euo pipefail

DB_USER=$1
HOST=${2:-localhost}

if [ -z "$DB_USER" ]; then
  echo "❌ Usage: $0 <db_user> [host]"
  exit 1
fi

echo "🧹 Removing MySQL user '${DB_USER}'@'${HOST}'..."

mysql -u root <<EOF
DROP USER IF EXISTS '${DB_USER}'@'${HOST}';
FLUSH PRIVILEGES;
EOF

echo "✅ User '${DB_USER}'@'${HOST}' removed successfully."

