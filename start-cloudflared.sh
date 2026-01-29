#!/bin/bash

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_FILE="$SCRIPT_DIR/cloudflared.log"
CONFIG_FILE="$SCRIPT_DIR/.cloudflared-port"

# Check if port is configured
if [ -f "$CONFIG_FILE" ]; then
    PORT=$(cat "$CONFIG_FILE")
else
    # Default port
    PORT=3010
    echo "$PORT" > "$CONFIG_FILE"
    echo "Created config file with default port: $PORT"
fi

# Start cloudflared in background
nohup cloudflared tunnel --url http://localhost:$PORT > "$LOG_FILE" 2>&1 &

echo "Cloudflared tunnel started in background (port: $PORT)"
echo "Log file: $LOG_FILE"
echo "Waiting for tunnel URL..."

# Wait for URL to appear in log (max 30 seconds)
for i in {1..30}; do
    if [ -f "$LOG_FILE" ]; then
        URL=$(grep -o 'https://[a-zA-Z0-9-]*\.trycloudflare\.com' "$LOG_FILE" | head -1)
        if [ ! -z "$URL" ]; then
            echo "Tunnel URL: $URL"
            echo "Opening in Chrome..."
            open -a "Google Chrome" "$URL"
            exit 0
        fi
    fi
    sleep 1
done

echo "Timeout waiting for tunnel URL. Check $LOG_FILE manually."
