#!/usr/bin/env bash
# Simple server healthcheck.
# Prints status and returns a code: 0 = all good, 1 = a proset -euo pipefail
# safe mode: fail on errors
echo "=== Healthcheck: $(hostname) ==="
echo "Time: $(date)"
# 1. Disk usage (warn if >80%)
disk_usage=$(df / | awk 'NR==2 {print $5}' | tr -d '%')
echo "Disk /: ${disk_usage}%"
if [ "$disk_usage" -gt 80 ]; then
    echo "WARNING: disk is more than 80% full"
    exit 1
fi
# 2. Free memory
free_mem=$(free -m | awk '/^Mem:/ {print $7}')
echo "Free memory: ${free_mem} MB"
# 3. Number of logged-in users
users=$(who | wc -l)
echo "Logged-in users: ${users}"
echo "=== All good ==="
exit 0
