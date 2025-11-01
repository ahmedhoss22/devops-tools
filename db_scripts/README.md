# Database Setup Scripts

This directory contains bash scripts for automated database and user setup on MySQL and PostgreSQL servers.

## Overview

These scripts automate the creation of databases and users with appropriate privileges, making it easy to set up development or production database environments.

## Scripts

### 1. `mysql.sh` - MySQL Database Setup

Creates a MySQL database and user with full privileges on the specified database.

#### Features

- Creates a database with UTF8MB4 character set and collation
- Creates a database user if it doesn't exist
- Grants all privileges on the database to the user
- Uses proper error handling with `set -e`

#### Prerequisites

- MySQL server installed and running
- Root access to MySQL (script must be run with `sudo` or as a user with MySQL root privileges)
- MySQL command-line client available

#### Usage

```bash
sudo ./mysql.sh <DB_NAME> <DB_USER> <DB_PASS> [root_pass]
```

#### Parameters

- `DB_NAME` - Name of the database to create
- `DB_USER` - Username for the database user
- `DB_PASS` - Password for the database user
- `root_pass` - (Optional) MySQL root password (currently not used in script)

#### Example

```bash
sudo ./mysql.sh lms_dev_user lms_user 'lms_p$$ass'
```

#### Output

The script will create the database and user, then display a success message.

---

### 2. `postgress.sh` - PostgreSQL Database Setup

Creates a PostgreSQL database and user with full privileges, including schema-level permissions.

#### Features

- Creates a PostgreSQL database
- Creates a database user with a password
- Grants all privileges on the database
- Grants schema-level privileges on the `public` schema
- Sets default privileges for future tables and sequences

#### Prerequisites

- PostgreSQL server installed and running
- `sudo` access (script switches to `postgres` user)
- PostgreSQL command-line client (`psql`) available

#### Usage

```bash
sudo ./postgress.sh <DB_NAME> <DB_USER> <DB_PASS>
```

#### Parameters

- `DB_NAME` - Name of the database to create
- `DB_USER` - Username for the database user
- `DB_PASS` - Password for the database user

#### Example

```bash
sudo ./postgress.sh lms_dev_user lms_user 'lms_p$$ass'
```

#### Output

The script will display a progress message and then a success message upon completion.

---

## Execution Instructions

### For MySQL

1. Navigate to the `db_scripts` directory:

   ```bash
   cd db_scripts
   ```

2. Make the script executable (if not already):

   ```bash
   chmod +x mysql.sh
   ```

3. Run the script with `sudo`:
   ```bash
   sudo ./mysql.sh <your_db_name> <your_db_user> <your_db_password>
   ```

### For PostgreSQL

1. Navigate to the `db_scripts` directory:

   ```bash
   cd db_scripts
   ```

2. Make the script executable (if not already):

   ```bash
   chmod +x postgress.sh
   ```

3. Run the script with `sudo`:
   ```bash
   sudo ./postgress.sh <your_db_name> <your_db_user> <your_db_password>
   ```

## Important Notes

- Both scripts require **sudo/administrator privileges** to execute
- Ensure the database server (MySQL/PostgreSQL) is running before executing the scripts
- For MySQL: The script connects as root without a password prompt. If your MySQL root user requires a password, you may need to modify the script or use a `.my.cnf` file
- For PostgreSQL: The script automatically switches to the `postgres` system user to execute database commands
- Use strong passwords in production environments
- These scripts are designed for setup automation and should be used with appropriate security considerations

## Troubleshooting

### MySQL Issues

- If you get "Access denied" errors, ensure you have root MySQL privileges
- Check that MySQL service is running: `sudo systemctl status mysql`

### PostgreSQL Issues

- If you get permission errors, ensure PostgreSQL service is running: `sudo systemctl status postgresql`
- Verify that the `postgres` system user exists and has proper permissions
