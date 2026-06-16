# openbase-coder-workspace

## Getting started

This repo is a [multi](https://github.com/montaguegabe/multi) workspace to manage multiple sub-repositories:

- [allauth-client-swift](https://github.com/openbase-community/allauth-client-swift) - SwiftUI client and views for Django AllAuth headless authentication
- [cli](https://github.com/openbase-community/openbase-coder) - CLI for Openbase Coder. This runs a Django server that provides git diffs for repos across the file system.
- [console](https://github.com/openbase-community/openbase-coder-console) - React frontend console for Openbase Coder
- [coder-react](https://github.com/openbase-community/openbase-coder-react) - Shared React UI package for Openbase Coder components used by the console and desktop clients
- [desktop](https://github.com/openbase-community/openbase-coder-desktop) - Electron desktop app for Openbase Coder
- [ios](https://github.com/openbase-community/openbase-ios) - Main Openbase iOS application using Tuist
- [skills](https://github.com/openbase-community/openbase-coder-skills) - Shared agent skills for Openbase Coder workflows
- [super-agents](https://github.com/montaguegabe/super-agents) - Python MCP wrapper for controlling Codex app-server threads, plus the packaged Claude backend proxy
- [multi-react](https://github.com/montaguegabe/multi-react) - Shared React diff viewer and related UI utilities used by Multi and Openbase Coder
- [boilersync-react](https://github.com/montaguegabe/boilersync-react) - Shared React components and utilities for BoilerSync template workflows

To get started, install multi with `uv tool install multi-workspace`.

Then run `./scripts/setup` from this checkout. The script uses the workspace root
that contains it as the Openbase setup workspace, even when the checkout lives
outside `~/.openbase`.

Default `~/.openbase/codex_home` instruction files are sourced from
[`instructions/`](instructions/).
Workspace skills under [`skills/skills/`](skills/skills/) are symlink-installed
into `~/.openbase/codex_home/skills`.

## Claude Backend

Openbase Coder setup defaults new installs to the Claude proxy backend. To route
Openbase Coder, the Codex App Server, and Super Agents through the packaged
Super Agents Claude proxy explicitly, run:

```bash
openbase-coder setup --backend claude-code-proxy
```

Switch back with:

```bash
super-agents-backend use codex
```

The Openbase managed `codex-claude-proxy` service keeps
`super-agents-claude-proxy` running, and `codex-app-server` passes Codex the
Claude Responses provider config when the Claude proxy backend is selected.
Restart `codex-app-server` after switching.

To bypass Codex app-server entirely and use Claude Code's local TUI backend:

```bash
openbase-coder setup --backend claude-tui
```

Then restart the MCP host that runs `super-agents-mcp`.
