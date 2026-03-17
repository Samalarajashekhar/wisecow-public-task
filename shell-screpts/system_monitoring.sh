#!/bin/bash

# -----------------------
# Configuration
# -----------------------
CPU_THRESHOLD=80        # in percent
MEM_THRESHOLD=80        # in percent
DISK_THRESHOLD=80       # in percent
PROCESS_THRESHOLD=300   # number of processes
LOG_FILE="/var/log/system_health.log"

# -----------------------
# Functions
# -----------------------

check_cpu() {
    CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print int($2 + $4)}')
    if [ "$CPU_USAGE" -gt "$CPU_THRESHOLD" ]; then
        echo "$(date): WARNING: CPU usage is high: ${CPU_USAGE}%" | tee -a $LOG_FILE
    fi
}

check_memory() {
    MEM_USAGE=$(free | awk '/Mem/ {print int($3/$2 * 100)}')
    if [ "$MEM_USAGE" -gt "$MEM_THRESHOLD" ]; then
        echo "$(date): WARNING: Memory usage is high: ${MEM_USAGE}%" | tee -a $LOG_FILE
    fi
}

check_disk() {
    DISK_USAGE=$(df / | awk 'NR==2 {print int($5)}')
    if [ "$DISK_USAGE" -gt "$DISK_THRESHOLD" ]; then
        echo "$(date): WARNING: Disk usage is high: ${DISK_USAGE}%" | tee -a $LOG_FILE
    fi
}

check_processes() {
    PROC_COUNT=$(ps aux | wc -l)
    if [ "$PROC_COUNT" -gt "$PROCESS_THRESHOLD" ]; then
        echo "$(date): WARNING: High number of processes: ${PROC_COUNT}" | tee -a $LOG_FILE
    fi
}

# -----------------------
# Main
# -----------------------
check_cpu
check_memory
check_disk
check_processes