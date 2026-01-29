#!/bin/bash

PORT=$(cat .cloudflared-port 2>/dev/null || echo "3010")

PID=$(ps aux | grep "cloudflared tunnel --url http://localhost:$PORT" | grep -v grep | awk '{print $2}')

if [ -n "$PID" ]; then
    kill $PID
    echo "Cloudflared tunnel stopped (port $PORT, PID $PID)"
else
    echo "No cloudflared process found for port $PORT"
fi
