# 🔧 Installation and Setup Guide

Follow these steps to replicate the Omni-Update environment or restore it after a system migration.

## 1. Prerequisites
- **macOS** (Tested on Apple Silicon)
- **Homebrew** installed in `/opt/homebrew`
- **Git** configured with your GitHub credentials

## 2. Install Dependencies
```bash
# Tap the autoupdate extension
brew tap homebrew/autoupdate

# Install terminal-notifier for macOS notifications
brew install terminal-notifier
```

## 3. Configure Homebrew Autoupdate
Run the following command to start the background service with a 12-hour interval (43200 seconds):
```bash
brew autoupdate start 43200 --upgrade --cleanup
```

## 4. Install NPM Global Automation
Move the `npm-omni-update.sh` script to your local bin and make it executable:
```bash
mkdir -p ~/.local/bin
cp npm-omni-update.sh ~/.local/bin/
chmod +x ~/.local/bin/npm-omni-update.sh
```

## 5. Load the Launch Agent
Copy the `.plist` file to your user LaunchAgents folder and load it into the system:
```bash
cp com.lurocha.npm-autoupdate.plist ~/Library/LaunchAgents/
launchctl load ~/Library/LaunchAgents/com.lurocha.npm-autoupdate.plist
```

## 🧪 Verification
To verify the system is running:
- **Brew:** `brew autoupdate status`
- **NPM:** `launchctl list | grep npm-autoupdate`
- **Logs:** `tail -f ~/Library/Logs/npm-autoupdate.log`

## 🆘 Troubleshooting
If notifications do not appear, ensure `terminal-notifier` is accessible in your PATH and that "Notifications" are enabled for it in macOS System Settings.
