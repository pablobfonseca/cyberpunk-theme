#!/usr/bin/env bash
# Cyberpunk theme for tmux
# Refined cyberpunk styling that complements terminal aesthetics
# Usage: source this file in your ~/.tmux.conf

# Cyberpunk color palette (refined for subtle elegance)
bg_dark='#0a0e14'      # Match terminal background
bg='#1a1f25'           # Slightly lighter for contrast
bg_light='#2a2f35'     # Status elements
fg='#e0e6f0'           # Main text
fg_dark='#8b93a6'      # Muted text
fg_gutter='#4a5568'    # Subtle accents

# Refined accent colors (less aggressive, more professional)
accent_cyan='#64d9ef'     # Softer cyan
accent_green='#5fb3a1'    # Muted green  
accent_purple='#a78bfa'   # Subtle purple
accent_orange='#f59e0b'   # Warm orange
accent_pink='#ec4899'     # Refined pink

# Status bar with clean background matching terminal
set-option -g status-style "fg=$fg,bg=$bg_dark"

# Window status - subtle and clean
set-option -g window-status-style "fg=$fg_dark,bg=$bg_dark"
set-option -g window-status-current-style "fg=$accent_cyan,bg=$bg,bold"
set-option -g window-status-activity-style "fg=$accent_orange,bg=$bg_dark"
set-option -g window-status-bell-style "fg=$accent_pink,bg=$bg_dark"

# Window status format - clean and minimal
set-option -g window-status-format " #I:#W#F "
set-option -g window-status-current-format " #I:#W#F "

# Pane borders - subtle and professional  
set-option -g pane-border-style "fg=$fg_gutter"
set-option -g pane-active-border-style "fg=$accent_cyan"

# Pane numbers
set-option -g display-panes-active-colour "$accent_pink"
set-option -g display-panes-colour "$accent_cyan"

# Clock
set-option -g clock-mode-colour "$accent_green"

# Copy mode highlighting
set-option -g mode-style "fg=$bg_dark,bg=$accent_cyan"

# Message text
set-option -g message-style "fg=$fg,bg=$bg"
set-option -g message-command-style "fg=$fg,bg=$bg"

# Status bar content
set-option -g status-left-length 100
set-option -g status-right-length 100

# Left status - clean session info (no emojis, professional)
set-option -g status-left "#[fg=$accent_cyan,bg=$bg,bold] #S #[fg=$bg,bg=$bg_dark,nobold]"

# Right status - minimal system info
set-option -g status-right "#[fg=$accent_green] %H:%M #[fg=$accent_purple] %d-%b #[fg=$fg,bg=$bg] #h "

# Window tabs styling
set-option -g status-justify left

# Selection highlighting in copy mode
set-option -g mode-style "fg=$bg_dark,bg=$accent_orange"

# Command prompt
set-option -g message-command-style "fg=$accent_cyan,bg=$bg"

# Automatic rename
set-option -g automatic-rename on
set-option -g automatic-rename-format '#{b:pane_current_path}'

# Activity monitoring
set-option -g monitor-activity on
set-option -g visual-activity off

# Status update interval
set-option -g status-interval 1

# Optional advanced styling (uncomment for enhanced effects)
# These provide more visual flair while maintaining the refined aesthetic

# # Enhanced status bar with subtle gradients
# set-option -g status-left "#[fg=$accent_cyan,bg=$bg,bold] #S #[fg=$bg,bg=$bg_dark,nobold]"
# set-option -g status-right "#[fg=$bg_dark,bg=$accent_green,nobold]#[fg=$bg_dark,bg=$accent_green,bold] %H:%M #[fg=$accent_green,bg=$accent_purple,nobold]#[fg=$fg,bg=$accent_purple,bold] %d-%b #[fg=$accent_purple,bg=$accent_cyan,nobold]#[fg=$bg_dark,bg=$accent_cyan,bold] #h "

# # Enhanced active window styling  
# set-option -g window-status-current-format "#[fg=$bg_dark,bg=$accent_cyan,nobold]#[fg=$bg_dark,bg=$accent_cyan,bold] #I:#W#F #[fg=$accent_cyan,bg=$bg_dark,nobold]"

echo "🌃 Cyberpunk tmux theme (refined) loaded successfully!"