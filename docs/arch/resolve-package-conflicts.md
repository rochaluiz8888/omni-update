# Resolve Package Conflicts: Homebrew, npm, and npx

## Objective
Evaluate and resolve conflicts between `homebrew`, `npm`, and `npx` installations of `node`, `npm`, and global packages. In accordance with user requirements, `homebrew` is the highest priority, and any overlapping packages must be removed from `npm` (global) and `npx` cache. Furthermore, best practices for prioritization between `npm` and `npx` will be established.

## Background & Motivation
The system currently has conflicts where foundational tools (`node`, `npm`, `npx`) are installed via both Homebrew (`/opt/homebrew/bin/`) and NVM (`/Users/lurocha/.nvm/`). NVM is currently prioritized in the `PATH` via `~/.zshrc`, meaning Homebrew's installations are shadowed. Additionally, `corepack` is installed as a global `npm` package under NVM, but is available via Homebrew.

## Scope & Impact
This plan will:
1. Remove NVM and its managed versions of `node`, `npm`, and `corepack` to ensure Homebrew's installations are the only ones used.
2. Remove NVM initialization from the shell configuration.
3. Install `corepack` via Homebrew.
4. Clear the `npx` cache to remove any potential conflicts with Homebrew packages.

## Proposed Solution: "Full Brew Priority"
By removing NVM entirely, we eliminate the source of the `node`/`npm`/`npx` conflict and guarantee that Homebrew is the ultimate source of truth for foundational development tools.

### Best Practices: `npm` vs `npx`
Going forward, the following prioritization should be observed:
1.  **Homebrew (Highest):** Always use `brew install <package>` for foundational developer tools (`node`, `corepack`, `yarn`, `pnpm`, `gemini-cli`) and system-wide services.
2.  **npx (Preferred for CLI execution):** Use `npx <package>` for ad-hoc execution, scaffolding tools (e.g., `create-react-app`), and tools you don't use daily. This ensures you always use the latest version and keeps the global environment clean.
3.  **npm -g (Lowest, use sparingly):** Only use `npm install -g <package>` for tools you use daily across multiple projects where the slight latency of `npx` is undesirable (e.g., `typescript`, `eslint`, though project-local installation is still strongly preferred).

## Implementation Steps
1.  **Uninstall NVM:**
    *   Remove the `~/.nvm` directory: `rm -rf ~/.nvm`
2.  **Clean Shell Configuration:**
    *   Edit `~/.zshrc` to remove the NVM initialization lines:
        ```bash
        export NVM_DIR=~/.nvm
        source $(brew --prefix nvm)/nvm.sh
        ```
    *   Uninstall the `nvm` Homebrew formula: `brew uninstall nvm`
3.  **Install Homebrew Packages:**
    *   Install `corepack` via Homebrew: `brew install corepack`
4.  **Clear npx Cache:**
    *   Remove the cached packages: `rm -rf ~/.npm/_npx`

## Verification
*   Open a new shell session (or `source ~/.zshrc`).
*   Run `which -a node npm npx corepack`. All should point to `/opt/homebrew/bin/` (or its cellar equivalent), with no NVM paths present.
*   Run `npm list -g --depth=0` to verify the clean global `npm` environment managed by Homebrew's Node.