# Omni-Update Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Automate Homebrew and global npm updates with background execution and native macOS notifications.

**Architecture:** Use `homebrew/autoupdate` for the core scheduling and `terminal-notifier` for the user interface. A custom wrapper script will handle the npm integration.

**Tech Stack:** Homebrew, npm, Zsh, Launch Agents, `terminal-notifier`.

---

### Task 1: Install Dependencies

**Files:**
- Modify: `~/.zshrc` (optional, for alias)

- [ ] **Step 1: Tap the autoupdate repository**
Run: `brew tap homebrew/autoupdate`
Expected: Success message from Homebrew.

- [ ] **Step 2: Install terminal-notifier**
Run: `brew install terminal-notifier`
Expected: `terminal-notifier` available in `/opt/homebrew/bin/`.

- [ ] **Step 3: Verify terminal-notifier**
Run: `terminal-notifier -message "Omni-Update test" -title "Omni-Update"`
Expected: A native macOS notification appears.

- [ ] **Step 4: Commit dependencies setup**
```bash
# No files to commit yet, just verifying environment
```

### Task 2: Configure Homebrew Autoupdate

**Files:**
- Create: `~/Library/LaunchAgents/com.github.domtark.homebrew-autoupdate.plist` (managed by brew)

- [ ] **Step 1: Start the autoupdate service**
Run: `brew autoupdate start 43200 --upgrade --cleanup --notify`
Expected: "Homebrew will now autoupdate every 43200 seconds."

- [ ] **Step 2: Verify service status**
Run: `brew autoupdate status`
Expected: Status showing "Scheduled" and parameters used.

### Task 3: Integrate Global npm Updates

**Files:**
- Create: `~/.local/bin/npm-omni-update.sh`
- Create: `~/Library/LaunchAgents/com.lurocha.npm-autoupdate.plist`

- [ ] **Step 1: Create the npm update script**
```bash
mkdir -p ~/.local/bin
cat << 'EOF' > ~/.local/bin/npm-omni-update.sh
#!/bin/zsh
# Omni-Update: npm helper
source ~/.zshrc 2>/dev/null
export PATH="/opt/homebrew/bin:$PATH"

if npm update -g; then
  /opt/homebrew/bin/terminal-notifier -message "Global NPM packages updated successfully." -title "Omni-Update"
else
  /opt/homebrew/bin/terminal-notifier -message "Global NPM update failed. Check logs." -title "Omni-Update" -subtitle "Error"
fi
EOF
chmod +x ~/.local/bin/npm-omni-update.sh
```

- [ ] **Step 2: Create the Launch Agent for npm**
```bash
cat << EOF > ~/Library/LaunchAgents/com.lurocha.npm-autoupdate.plist
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.lurocha.npm-autoupdate</string>
    <key>ProgramArguments</key>
    <array>
        <string>/bin/zsh</string>
        <string>/Users/lurocha/.local/bin/npm-omni-update.sh</string>
    </array>
    <key>StartInterval</key>
    <integer>43200</integer>
    <key>StandardOutPath</key>
    <string>/Users/lurocha/Library/Logs/npm-autoupdate.log</string>
    <key>StandardErrorPath</key>
    <string>/Users/lurocha/Library/Logs/npm-autoupdate.log</string>
</dict>
</plist>
EOF
```

- [ ] **Step 3: Load the npm Launch Agent**
Run: `launchctl load ~/Library/LaunchAgents/com.lurocha.npm-autoupdate.plist`
Expected: Service loaded without error.

- [ ] **Step 4: Verify npm update script**
Run: `~/.local/bin/npm-omni-update.sh`
Expected: A notification for npm success/failure.

### Task 4: Final System Verification

- [ ] **Step 1: Run a full manual update cycle**
Run: `brew autoupdate run --notify && ~/.local/bin/npm-omni-update.sh`
Expected: Two notifications (one for Brew, one for npm).

- [ ] **Step 2: Check logs**
Run: `ls ~/Library/Logs/homebrew-autoupdate.log && ls ~/Library/Logs/npm-autoupdate.log`
Expected: Log files exist and contain recent entries.
