#!/usr/bin/env bash
# Cyberpunk theme for tmux - Advanced Integration
# Designed to work with existing sophisticated tmux setups
# Provides Catppuccin-style variables with cyberpunk colors

# Cyberpunk color palette
bg_dark='#0a0e14'      # Deep dark background
bg='#1a1f25'           # Main background  
bg_light='#2a2f35'     # Lighter background
fg='#e0e6f0'           # Main foreground
fg_dark='#8b93a6'      # Muted foreground
fg_gutter='#4a5568'    # Gutter/border

# Cyberpunk accent colors (refined)
accent_cyan='#64d9ef'     # Soft cyan
accent_green='#5fb3a1'    # Muted green  
accent_purple='#a78bfa'   # Subtle purple
accent_orange='#f59e0b'   # Warm orange
accent_pink='#ec4899'     # Refined pink
accent_blue='#60a5fa'     # Soft blue
accent_yellow='#fbbf24'   # Warm yellow
accent_red='#f87171'      # Soft red

# Define Catppuccin-style theme variables with cyberpunk colors
# This allows existing status bar configs to work seamlessly
set -g @thm_bg "$bg_dark"
set -g @thm_fg "$fg" 
set -g @thm_cyan "$accent_cyan"
set -g @thm_black "$bg_dark"
set -g @thm_gray "$fg_gutter"
set -g @thm_magenta "$accent_purple"
set -g @thm_pink "$accent_pink"
set -g @thm_red "$accent_red"
set -g @thm_green "$accent_green"
set -g @thm_yellow "$accent_yellow"
set -g @thm_blue "$accent_blue"
set -g @thm_orange "$accent_orange"
set -g @thm_black4 "$bg_light"

# Catppuccin Mocha equivalent colors with cyberpunk palette
set -g @thm_rosewater "$fg_dark"
set -g @thm_flamingo "$accent_pink"
set -g @thm_mauve "$accent_purple"
set -g @thm_maroon "$accent_red"
set -g @thm_peach "$accent_orange"
set -g @thm_teal "$accent_cyan"
set -g @thm_sky "$accent_blue"
set -g @thm_sapphire "$accent_cyan"
set -g @thm_lavender "$accent_purple"
set -g @thm_text "$fg"
set -g @thm_subtext1 "$fg_dark"
set -g @thm_subtext0 "$fg_gutter"
set -g @thm_overlay2 "$fg_gutter"
set -g @thm_overlay1 "$bg_light"
set -g @thm_overlay0 "$bg"
set -g @thm_surface2 "$bg_light"
set -g @thm_surface1 "$bg"
set -g @thm_surface0 "$bg_dark"
set -g @thm_mantle "$bg_dark"
set -g @thm_crust "$bg_dark"

# Core tmux styling with cyberpunk colors
set-option -g status-style "fg=$fg,bg=$bg_dark"

# Window status
set-option -g window-status-style "fg=$fg_dark,bg=$bg_dark"
set-option -g window-status-current-style "fg=$bg_dark,bg=$accent_cyan,bold"
set-option -g window-status-activity-style "fg=$accent_red,bg=$bg_dark"
set-option -g window-status-bell-style "fg=$accent_orange,bg=$bg_dark"

# Pane borders (cyberpunk style)
set-option -g pane-border-style "fg=$fg_gutter"
set-option -g pane-active-border-style "fg=$accent_cyan"

# Window styling (cyberpunk backgrounds)
set-option -g window-style "bg=$bg_dark,fg=$fg_dark"
set-option -g window-active-style "bg=$bg_dark,fg=$fg"

# Message and command styling
set-option -g message-style "fg=$fg,bg=$bg"
set-option -g message-command-style "fg=$accent_cyan,bg=$bg"

# Copy mode
set-option -g mode-style "fg=$bg_dark,bg=$accent_cyan"

# Clock
set-option -g clock-mode-colour "$accent_green"

# Bell and activity
set-option -g window-status-bell-style "fg=$bg_dark,bg=$accent_red,bold"
set-option -g window-status-activity-style "fg=$accent_orange,bg=$bg_dark"

echo "🌃 Cyberpunk tmux theme (advanced integration) loaded!"