#!/bin/bash

threshold=90

# Monitor CPU usage and trigger alert if threshold exceeded
cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')  # Add user and system usage

if (( $(echo "$cpu_usage > $threshold" | bc -l) )); then
    echo "High CPU usage detected: ${cpu_usage}%"
    # Add alert/notification logic here, e.g., send an email
fi
