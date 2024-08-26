#!/bin/bash

backup_dir="/path/to/backup"
source_dir="/path/to/source"

# Create a timestamped backup of the source directory
tar -czf "${backup_dir}/backup_$(date +%Y%m%d_%H%M%S).tar.gz" -C "$source_dir" .

# Optionally: Remove old backups if space is an issue
find "$backup_dir" -type f -name "*.tar.gz" -mtime +30 -exec rm {} \;

echo "Backup completed."
