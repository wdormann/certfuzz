#!/bin/sh
FILE=/tmp/bff_watchdog
AGE_LIMIT=3600  # seconds

# If file does not exist, PASS (no reboot)
[ ! -f "$FILE" ] && exit 0

# If file exists but is older than AGE_LIMIT, FAIL
if [ $(( $(date +%s) - $(stat -c %Y "$FILE") )) -gt $AGE_LIMIT ]; then
    echo "watchdog: $FILE older than $AGE_LIMIT seconds" >&2
    exit 1
fi

# Otherwise PASS
exit 0
