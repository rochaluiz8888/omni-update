# Omni-Update: Automated Background Maintenance System

## Objective
Establish a robust, automated background service for macOS that ensures Homebrew (formulas and casks) and global npm packages are always up to date. The system should operate silently but provide user feedback via native macOS notifications upon completion or failure.

## Background & Motivation
The user has transitioned to a "Homebrew Priority" environment where foundational tools (`node`, `npm`, `npx`, `corepack`, `gemini-cli`) are managed by Homebrew. Manual updates are prone to being forgotten, leading to security vulnerabilities and outdated features. A background automation ensures a modern and secure developer environment with zero manual effort.

## Scope & Impact
This design will:
1.  Automate `brew update`, `brew upgrade`, and `brew cleanup`.
2.  Automate `npm update -g` for any global packages managed by Homebrew's npm.
3.  Implement a Launch Agent (via `homebrew/autoupdate`) to handle the periodic execution.
4.  Integrate native macOS notifications using `terminal-notifier`.
5.  Provide logging for auditability and troubleshooting.

## Technical Architecture

### 1. Dependency Management
The system relies on two key components:
- **`homebrew/autoupdate` Tap:** An official Homebrew extension for scheduling background updates.
- **`terminal-notifier`:** A CLI tool for sending native macOS notifications.

### 2. Execution Logic
The update process will follow this sequence:
1.  **Sync Metadata:** `brew update`
2.  **Upgrade Core:** `brew upgrade` (covers both formulas and casks)
3.  **Global npm Packages:** `npm update -g`
4.  **Cleanup:** `brew cleanup`
5.  **Notify:** Trigger a macOS notification using `terminal-notifier`.

### 3. Scheduling
- **Frequency:** Every 12 hours.
- **Trigger:** Managed by a macOS Launch Agent (`~/Library/LaunchAgents/com.github.domtark.homebrew-autoupdate.plist`).

### 4. Notification Design
- **Success:** "📦 System Update Complete - Homebrew and Global NPM packages are now up to date."
- **Failure:** "⚠️ System Update Failed - Check ~/Library/Logs/homebrew-autoupdate.log for details."

## Implementation Plan
1.  **Install Dependencies:**
    *   `brew tap homebrew/autoupdate`
    *   `brew install terminal-notifier`
2.  **Configure & Start Service:**
    *   Run `brew autoupdate start 43200 --upgrade --cleanup --notify` (43200 seconds = 12 hours).
3.  **Custom npm Integration:**
    *   Since `brew autoupdate` primarily handles Brew, I will create a small wrapper script or a separate Launch Agent to ensure `npm update -g` is also included in the cycle if `brew autoupdate` doesn't natively support custom commands. (Note: `brew autoupdate` is specifically for Homebrew; for `npm -g`, a separate companion script is more reliable).

## Verification
1.  Check if the service is running: `brew autoupdate status`
2.  Manually trigger a test run to verify notifications: `brew autoupdate run --notify`
3.  Check log files for success entries.

## Self-Review
- **Ambiguity:** `brew autoupdate` natively handles `--notify` if `terminal-notifier` is present.
- **Conflict:** None identified with the existing Homebrew setup.
- **Scope:** Correctly balances background automation with user visibility.

## User Approval
Spec written and committed to `/Users/lurocha/conductor/2026-04-08-omni-update-design.md`. Please review it and let me know if you want to make any changes before we start writing out the implementation plan.