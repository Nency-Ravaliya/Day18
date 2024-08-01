#!/bin/bash

# Set variables
DB_NAME="mydatabase"
BACKUP_DIR="/var/backups/postgresql"
BACKUP_FILE="${BACKUP_DIR}/${DB_NAME}_backup_$(date +%F_%H-%M-%S).sql.gz"
LOG_FILE="/var/log/backup_script.log"

# Create the backup directory if it does not exist
mkdir -p "$BACKUP_DIR"

# Perform the backup
pg_dump "$DB_NAME" > "$BACKUP_FILE" 2>> "$LOG_FILE"

# Optionally, you can compress the backup
gzip "$BACKUP_FILE" 2>> "$LOG_FILE"

# Remove backups older than 7 days
find "$BACKUP_DIR" -type f -name "*.sql.gz" -mtime +7 -exec rm {} \;

echo "Backup completed: $BACKUP_FILE.gz" >> "$LOG_FILE"
