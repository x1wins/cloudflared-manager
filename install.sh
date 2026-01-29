#!/bin/bash
set -e

BASE_URL="${BASE_URL:-https://raw.githubusercontent.com/x1wins/cloudflared-manager/main}"

echo "Downloading cloudflared scripts..."
curl -fsSL "$BASE_URL/init-cloudflared.sh" -o init-cloudflared.sh
curl -fsSL "$BASE_URL/start-cloudflared.sh" -o start-cloudflared.sh
curl -fsSL "$BASE_URL/stop-cloudflared.sh" -o stop-cloudflared.sh
curl -fsSL "$BASE_URL/view-cloudflared-log.sh" -o view-cloudflared-log.sh

chmod +x *.sh

echo "✓ Installation complete"
echo "Run ./init-cloudflared.sh to configure"
