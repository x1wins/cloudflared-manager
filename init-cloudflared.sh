#!/bin/bash

if [ -f .cloudflared-port ]; then
    CURRENT_PORT=$(cat .cloudflared-port)
    echo "Port configuration already exists: $CURRENT_PORT"
    read -p "Do you want to change it? (y/n): " CHANGE
    if [ "$CHANGE" != "y" ]; then
        exit 0
    fi
fi

read -p "Enter port number (default: 3010): " PORT
PORT=${PORT:-3010}

echo "$PORT" > .cloudflared-port
echo "Created .cloudflared-port with port $PORT"
