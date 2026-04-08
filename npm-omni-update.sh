#!/bin/zsh
# Omni-Update: npm helper
source /Users/lurocha/.zshrc 2>/dev/null
export PATH="/opt/homebrew/bin:$PATH"

if /opt/homebrew/bin/npm update -g; then
  /opt/homebrew/bin/terminal-notifier -message "Global NPM packages updated successfully." -title "Omni-Update"
else
  /opt/homebrew/bin/terminal-notifier -message "Global NPM update failed. Check logs." -title "Omni-Update" -subtitle "Error"
fi
