# cloudflared-manager

Management scripts for Cloudflare Tunnel to expose local services publicly.

## Quick Install

```bash
curl -fsSL https://raw.githubusercontent.com/x1wins/cloudflared-manager/main/install.sh | bash
```

Or inspect before running:
```bash
curl -fsSL https://raw.githubusercontent.com/x1wins/cloudflared-manager/main/install.sh -o install.sh
bash install.sh
```

Then configure and start:
```bash
./init-cloudflared.sh
./start-cloudflared.sh
```

## Manual Setup

If you prefer to clone the repository:

```bash
git clone https://github.com/x1wins/cloudflared-manager.git
cd cloudflared-manager
chmod +x *.sh
./init-cloudflared.sh
./start-cloudflared.sh
```

## Prerequisites

- [cloudflared](https://developers.cloudflare.com/cloudflare-one/connections/connect-apps/install-and-setup/installation/) installed
- macOS or Linux

## Usage

Create a public URL for your local Web UI:

```bash
cloudflared tunnel --url http://localhost:3010
```

This generates a temporary public URL (e.g., `https://random-name.trycloudflare.com`) that tunnels to your local Web UI.

**Run in background:**
```bash
nohup cloudflared tunnel --url http://localhost:3010 > cloudflared.log 2>&1 &
```

**Auto-start on Mac restart:**

1. Create launchd service:
```bash
cat > ~/Library/LaunchAgents/com.cloudflare.cloudflared.plist << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.cloudflare.cloudflared</string>
    <key>ProgramArguments</key>
    <array>
        <string>/usr/local/bin/cloudflared</string>
        <string>tunnel</string>
        <string>--url</string>
        <string>http://localhost:3010</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <true/>
    <key>StandardOutPath</key>
    <string>/tmp/cloudflared.log</string>
    <key>StandardErrorPath</key>
    <string>/tmp/cloudflared.error.log</string>
</dict>
</plist>
EOF
```

2. Load and start:
```bash
launchctl load ~/Library/LaunchAgents/com.cloudflare.cloudflared.plist
launchctl start com.cloudflare.cloudflared
```

3. Manage service:
```bash
# Stop
launchctl stop com.cloudflare.cloudflared

# Disable auto-start
launchctl unload ~/Library/LaunchAgents/com.cloudflare.cloudflared.plist

# Check status
launchctl list | grep cloudflared
```

## Multi-Project Cloudflare Tunnel Setup

For this project (port 3010):
- Already created .cloudflared-port with 3010

For other projects:
1. Copy the 3 scripts to the new project
2. Create .cloudflared-port file with the port number:
```bash
echo "3000" > .cloudflared-port
```

Or just run ./start-cloudflared.sh and it will create the config
with default port 3010, then edit it:
```bash
echo "8080" > .cloudflared-port
```

Example for multiple projects:
```bash
# Project 1 (port 3010)
cd /path/to/project1
echo "3010" > .cloudflared-port

# Project 2 (port 8080)
cd /path/to/project2
echo "8080" > .cloudflared-port

# Project 3 (port 5000)
cd /path/to/project3
echo "5000" > .cloudflared-port
```
