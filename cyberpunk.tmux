#!/usr/bin/env bash
# Cyberpunk theme for tmux — TPM entry point

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

tmux source-file "$CURRENT_DIR/extras/tmux/cyberpunk_options.conf"
tmux source-file "$CURRENT_DIR/extras/tmux/cyberpunk_tmux.conf"
