#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_FILE="$SCRIPT_DIR/cloudflared.log"

if [ ! -f "$LOG_FILE" ]; then
    echo "Log file not found: $LOG_FILE"
    echo "Start the tunnel first with ./start-cloudflared.sh"
    exit 1
fi

tail -n 100 -f "$LOG_FILE"
