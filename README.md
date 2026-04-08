# 📦 Omni-Update

> **Automated Background Maintenance System for macOS**

Omni-Update is a zero-touch maintenance system designed for macOS developers who prioritize **Homebrew** as their primary package manager. It automates the synchronization and upgrading of Homebrew formulas, casks, and global NPM packages, providing native macOS notifications upon completion.

## 🚀 Features

- **Automated Brew Maintenance:** Periodically runs `brew update`, `brew upgrade`, and `brew cleanup`.
- **Global NPM Synchronization:** Automatically updates global NPM packages managed via Homebrew's Node.js.
- **Native Notifications:** Uses `terminal-notifier` to provide real-time feedback in the macOS Notification Center.
- **Background Execution:** Leverages macOS `launchd` for reliable, battery-aware scheduling.
- **"Homebrew-First" Architecture:** Specifically designed to resolve and prevent conflicts between NVM, global NPM, and Brew.

## 🛠 Tech Stack

- **Package Manager:** Homebrew
- **Runtime:** Node.js (Brew-managed)
- **Scheduling:** macOS Launch Agents (`launchd`)
- **Automation:** Zsh + `homebrew/autoupdate`
- **UI:** `terminal-notifier`

## 📂 Project Structure

- `npm-omni-update.sh`: The core automation script for global NPM packages.
- `com.lurocha.npm-autoupdate.plist`: The macOS Launch Agent configuration.
- `README.md`: This documentation.
- `PLAN.md`: The original implementation strategy.
- `INSTALL.md`: Detailed setup and recovery instructions.

---
*Maintained by [rochaluiz8888](https://github.com/rochaluiz8888)*
