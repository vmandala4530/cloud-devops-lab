#!/bin/bash

# Author: Vishnu Mandala
# Date: July 25, 2025
# Purpose: DevOps learning script to monitor CPU and restart a service

# cpu_monitor_restart.sh
# Simple script to check CPU usage and restart a service if usage exceeds threshold

SERVICE="apache2"   # You can change this to nginx, sshd, etc.
THRESHOLD=85        # CPU usage threshold (%)

# Get CPU usage using top and awk
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}' | cut -d. -f1)

echo "Current CPU usage: $CPU_USAGE%"

# Compare and take action
if [ "$CPU_USAGE" -gt "$THRESHOLD" ]; then
    echo "CPU usage is above $THRESHOLD%. Restarting $SERVICE..."
    sudo systemctl restart "$SERVICE"

    if [ $? -eq 0 ]; then
        echo "$SERVICE restarted successfully."
    else
        echo "Failed to restart $SERVICE."
    fi
else
    echo "CPU usage is normal."
fi
