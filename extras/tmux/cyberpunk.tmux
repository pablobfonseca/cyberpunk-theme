#!/usr/bin/env bash
# Cyberpunk theme for tmux
# Neon-soaked terminal multiplexer styling
# Usage: source this file in your ~/.tmux.conf

# Cyberpunk color palette
bg_dark='#060a0f'
bg='#0a0e14' 
bg_light='#1a1f25'
fg='#e0e6f0'
fg_dark='#b4bcc8'
fg_gutter='#3b4458'

# Neon colors
neon_pink='#ff007f'
neon_cyan='#00ffff'
neon_green='#00ff41'
neon_purple='#bf00ff'
neon_orange='#ff8800'
neon_blue='#0080ff'
neon_yellow='#ffff00'

# Status bar colors
set-option -g status-style "fg=$fg,bg=$bg_dark"

# Window status
set-option -g window-status-style "fg=$fg_dark,bg=$bg_dark"
set-option -g window-status-current-style "fg=$neon_cyan,bg=$bg_light,bold"
set-option -g window-status-activity-style "fg=$neon_pink,bg=$bg_dark"
set-option -g window-status-bell-style "fg=$neon_orange,bg=$bg_dark"

# Window status format
set-option -g window-status-format " #I:#W#F "
set-option -g window-status-current-format " #I:#W#F "

# Pane borders
set-option -g pane-border-style "fg=$fg_gutter"
set-option -g pane-active-border-style "fg=$neon_cyan"

# Pane numbers
set-option -g display-panes-active-colour "$neon_pink"
set-option -g display-panes-colour "$neon_cyan"

# Clock
set-option -g clock-mode-colour "$neon_green"

# Copy mode highlighting
set-option -g mode-style "fg=$bg,bg=$neon_cyan"

# Message text
set-option -g message-style "fg=$fg,bg=$bg_light"
set-option -g message-command-style "fg=$fg,bg=$bg_light"

# Status bar content
set-option -g status-left-length 100
set-option -g status-right-length 100

# Left status (session info with neon styling)
set-option -g status-left "#[fg=$neon_pink,bg=$bg_light,bold] ⚡ #S #[fg=$bg_light,bg=$bg_dark]"

# Right status (system info with cyberpunk flair)
set-option -g status-right "#[fg=$neon_green]🌐 %H:%M #[fg=$neon_purple]📅 %d-%b #[fg=$neon_cyan,bg=$bg_light,bold] #h "

# Window tabs styling
set-option -g status-justify left

# Selection highlighting in copy mode
set-option -g mode-style "fg=$bg,bg=$neon_orange"

# Command prompt
set-option -g message-command-style "fg=$neon_cyan,bg=$bg_light"

# Automatic rename
set-option -g automatic-rename on
set-option -g automatic-rename-format '#{b:pane_current_path}'

# Activity monitoring
set-option -g monitor-activity on
set-option -g visual-activity off

# Status update interval (for that real-time cyberpunk feel)
set-option -g status-interval 1

# Additional cyberpunk styling options
# Uncomment these for extra neon effects (may require tmux 3.0+)

# # Gradient-like status bar
# set-option -g status-left "#[fg=$neon_pink,bg=$bg_light,bold]⚡#S#[fg=$bg_light,bg=$bg,nobold]#[fg=$neon_cyan,bg=$bg] "
# set-option -g status-right "#[fg=$bg,bg=$neon_green,nobold]#[fg=$bg_dark,bg=$neon_green,bold] %H:%M #[fg=$neon_green,bg=$neon_purple,nobold]#[fg=$fg,bg=$neon_purple,bold] %d-%b #[fg=$neon_purple,bg=$neon_cyan,nobold]#[fg=$bg_dark,bg=$neon_cyan,bold] #h "

# # Active window with special highlight
# set-option -g window-status-current-format "#[fg=$bg,bg=$neon_cyan,nobold]#[fg=$bg_dark,bg=$neon_cyan,bold] #I:#W#F #[fg=$neon_cyan,bg=$bg_dark,nobold]"

echo "🌃 Cyberpunk tmux theme loaded - Welcome to the neon grid!"