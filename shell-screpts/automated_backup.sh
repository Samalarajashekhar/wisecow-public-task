#!/bin/bash

# ----------------------------
# Configuration
# ----------------------------
SOURCE_DIR="/usr/local/etc"          
REMOTE_USER="ec2-user"              
REMOTE_HOST="192.168.72.16"       
REMOTE_DIR="/home/ec2-user"          
LOG_FILE="/var/log/backup_report.log" 

# ----------------------------
# Create backup
# ----------------------------
echo "Backup started at $(date)" | tee -a $LOG_FILE

# Run rsync to copy files
rsync -avz --delete "$SOURCE_DIR/" "$REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR"
STATUS=$?

# ----------------------------
# Check result and report
# ----------------------------
if [ $STATUS -eq 0 ]; then
    echo "$(date): Backup completed successfully." | tee -a $LOG_FILE
else
    echo "$(date): ERROR: Backup failed with status $STATUS." | tee -a $LOG_FILE
fi