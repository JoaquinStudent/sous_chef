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
- [super-agents](https://github.com/montaguegabe/super-agents) - Python MCP wrapper for controlling Codex app-server threads and Claude Agent SDK/TUI backends
- [multi-react](https://github.com/montaguegabe/multi-react) - Shared React diff viewer and related UI utilities used by Multi and Openbase Coder
- [boilersync-react](https://github.com/montaguegabe/boilersync-react) - Shared React components and utilities for BoilerSync template workflows

To get started, install multi with `uv tool install multi-workspace`.

Then run `./scripts/setup` from this checkout. The script uses the workspace root
that contains it as the Openbase setup workspace, even when the checkout lives
outside `~/.openbase`.

Default `~/.openbase/codex_home` instruction files are symlinked from
[`instructions/`](instructions/).
Workspace skills under [`skills/skills/`](skills/skills/) are symlink-installed
into `~/.openbase/codex_home/skills`.

## Claude Backend

Openbase Coder setup defaults new installs to the Claude Agent SDK backend. To
route Super Agents through the Claude Agent SDK explicitly, run:

```bash
openbase-coder setup --backend claude-agent-sdk
```

Switch back with:

```bash
super-agents-backend use codex
```

The Claude Agent SDK backend bypasses `codex-app-server`; restart the MCP host
that runs `super-agents-mcp` after switching.

To bypass Codex app-server entirely and use Claude Code's local TUI backend:

```bash
openbase-coder setup --backend claude-tui
```

Then restart the MCP host that runs `super-agents-mcp`.
