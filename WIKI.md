# 📖 Omni-Update Knowledge Base (Wiki)

Welcome to the project's knowledge base. This documentation expands on our core maintenance principles and common scenarios for automated macOS package management.

## 🏛 Project Philosophy
The primary goal of this repository is to maintain a **Conflict-Free Developer Environment**. By strictly prioritizing Homebrew, we avoid the version mismatches and permission errors common in fragmented Node.js/NVM/NPM setups.

## 📜 Table of Contents
1. [NVM to Brew Migration Guide](#nvm-to-brew-migration-guide)
2. [Why Prioritize Homebrew?](#why-prioritize-homebrew)
3. [NPM vs NPX Best Practices](#npm-vs-npx-best-practices)
4. [Launch Agent Maintenance](#launch-agent-maintenance)

### NVM to Brew Migration Guide
The system assumes you have already migrated away from NVM. If you still have NVM installed, follow these steps:
- Remove `~/.nvm`
- Remove NVM exports from `~/.zshrc` or `~/.bash_profile`
- `brew install node`
- `npm config set prefix /opt/homebrew`

### Why Prioritize Homebrew?
- **Stability:** Brew handles macOS permissions natively, avoiding `sudo npm install -g`.
- **Atomic Updates:** Homebrew's symlinking strategy ensures consistent binary resolution across all your shells.
- **Security:** Formulas are audited and signed by the Homebrew maintainers.

### NPM vs NPX Best Practices
Omni-Update encourages a "Thin Global Environment":
- **Install globally via Brew/NPM:** Only tools you use *daily* across *multiple* projects (e.g., `typescript`, `corepack`, `gemini-cli`).
- **Use via NPX:** For ad-hoc execution or project scaffolding (e.g., `npx create-next-app`). This keeps your system clean and ensures you always run the latest versions.

### Launch Agent Maintenance
The background services are managed by `launchd`. If you need to stop them:
- **Brew:** `brew autoupdate stop`
- **NPM:** `launchctl unload ~/Library/LaunchAgents/com.lurocha.npm-autoupdate.plist`

To inspect execution logs:
- `cat ~/Library/Logs/homebrew-autoupdate.log`
- `cat ~/Library/Logs/npm-autoupdate.log`

---
*For further information, please refer to the [INSTALL.md](./INSTALL.md) file.*
