#!/usr/bin/env bash
# Claude Code session status widget for tmux statusbar

# Only show if claude-session-manager is installed
command -v claude-session-manager >/dev/null 2>&1 || exit 0

claude-session-manager widget
