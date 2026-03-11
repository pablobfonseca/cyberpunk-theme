#!/usr/bin/env bash
# Cyberpunk theme for tmux — TPM entry point

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Export scripts path so statusbar #() calls can find them
tmux set -g @_cp_scripts "$CURRENT_DIR/extras/tmux/scripts"

# Ensure scripts are executable
chmod +x "$CURRENT_DIR/extras/tmux/scripts/"*.sh 2>/dev/null

tmux source-file "$CURRENT_DIR/extras/tmux/cyberpunk_options.conf"
tmux source-file "$CURRENT_DIR/extras/tmux/cyberpunk_tmux.conf"
