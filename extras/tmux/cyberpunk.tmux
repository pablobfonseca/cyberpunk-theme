#!/usr/bin/env bash
# Cyberpunk theme for tmux - Advanced Integration with Status Bar Enhancement
# Designed to work with sophisticated tmux setups
# Preserves existing status bar layout while adding cyberpunk aesthetics

# ========================================
# CYBERPUNK COLOR PALETTE
# ========================================

# Background colors (deep space vibes)
bg_dark='#0a0e14'      # Deep dark background (inactive panels)
bg='#1a1f25'           # Main background (active panels)  
bg_light='#2a2f35'     # Lighter background (status elements)
bg_float='#0e1419'     # Floating elements

# Foreground colors
fg='#e0e6f0'           # Main foreground (active text)
fg_dark='#8b93a6'      # Muted foreground (inactive text)
fg_gutter='#4a5568'    # Gutter/border elements

# Cyberpunk accent colors (refined and professional)
accent_cyan='#64d9ef'     # Primary accent - functions, highlights
accent_green='#5fb3a1'    # Success states, online status  
accent_purple='#a78bfa'   # Secondary accent, special states
accent_orange='#f59e0b'   # Warnings, current window
accent_pink='#ec4899'     # Alerts, prefix active
accent_blue='#60a5fa'     # Info states, paths
accent_yellow='#fbbf24'   # Attention, zoom indicators
accent_red='#f87171'      # Errors, battery low, offline

# ========================================
# CATPPUCCIN-STYLE VARIABLES
# ========================================
# These allow existing sophisticated configs to work seamlessly

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

# Extended Catppuccin Mocha compatibility
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

# ========================================
# CORE TMUX STYLING
# ========================================

# Main status bar
set-option -g status-style "fg=$fg,bg=$bg_dark"

# Pane borders with cyberpunk accent (refined)
set-option -g pane-border-style "fg=$fg_gutter"
set-option -g pane-active-border-style "fg=$accent_cyan"

# ========================================
# DIM PANEL FEATURE (PRESERVED)
# ========================================
# Inactive panes are dimmed for better focus
set-option -g window-style "bg=$bg_dark,fg=$fg_dark"
set-option -g window-active-style "bg=$bg,fg=$fg"

# ========================================
# STATUS BAR ENHANCEMENTS
# ========================================
# Your existing status bar layout is preserved but enhanced

# Window status styling (compatible with your format)
set-option -g window-status-style "fg=#{@thm_rosewater},bg=#{@thm_bg}"
set-option -g window-status-last-style "fg=#{@thm_peach},bg=#{@thm_bg}"
set-option -g window-status-activity-style "fg=#{@thm_red},bg=#{@thm_bg}"
set-option -g window-status-bell-style "fg=#{@thm_red},bg=#{@thm_bg},bold"
set-option -g window-status-current-style "fg=#{@thm_bg},bg=#{@thm_peach},bold"

# Enhanced separator with subtle cyberpunk glow
set -gF window-status-separator "#[fg=#{@thm_overlay0}]│"

# Message and command styling  
set-option -g message-style "fg=$fg,bg=$bg_light"
set-option -g message-command-style "fg=$accent_cyan,bg=$bg_light"

# Copy mode with cyberpunk highlights
set-option -g mode-style "fg=$bg_dark,bg=$accent_cyan"

# Clock with cyberpunk accent
set-option -g clock-mode-colour "$accent_green"

# ========================================
# STATUS BAR IMPROVEMENTS
# ========================================
# Subtle enhancements to your existing layout

# Enhanced status positioning and justification
set-option -g status-position top
set-option -g status-justify "absolute-centre"

# Improved status update interval for real-time feel
set-option -g status-interval 5

# Optional: Enhanced pane number display
set-option -g display-panes-active-colour "$accent_pink"
set-option -g display-panes-colour "$accent_cyan"
set-option -g display-panes-time 2000

# ========================================
# OPTIONAL STATUS BAR ENHANCEMENTS
# ========================================
# Uncomment these sections to enhance your existing status bar

# Enhanced CPU display with color coding
# Replaces: #{cpu_percentage}
# set -ga status-right "│ #{?#{e|>=:80,#{cpu_percentage}},#[fg=#{@thm_red}],#{?#{e|>=:60,#{cpu_percentage}},#[fg=#{@thm_yellow}],#[fg=#{@thm_green}]}}#{@cpu_icon} #{cpu_percentage}#[fg=#{@thm_text}] "

# Enhanced battery with more color states  
# Replaces your battery section with smoother color transitions
# set -ga status-right "#{?#{e|>=:20,#{battery_percentage}},#{?#{e|>=:50,#{battery_percentage}},#[fg=#{@thm_green}],#[fg=#{@thm_yellow}]},#[fg=#{@thm_red}]#[bold]} #{battery_icon} #{battery_percentage} "

# Enhanced session name with git branch (if in git repo)
# Adds subtle git context to your session display
# set -ga status-left "#[fg=#{@thm_cyan},bg=#{@thm_bg},bold] #S #{?#{!=:#{b:pane_current_path},.git},#[fg=#{@thm_overlay0}]󰊢 #[fg=#{@thm_mauve}]#{b:pane_current_path},} "

# Enhanced zoom indicator with pulsing effect
# Makes the zoom indicator more prominent
# set -ga status-left "#[bg=#{@thm_bg},fg=#{@thm_overlay0},none]#{?window_zoomed_flag,│,}"
# set -ga status-left "#[bg=#{@thm_bg},fg=#{@thm_yellow},bold]#{?window_zoomed_flag, 🔍 ZOOM ,}"

# Enhanced online status with better icons
# set -ga status-right "#{?#{==:#{online_status},ok},#[fg=#{@thm_green}] 󰖩 connected ,#[fg=#{@thm_red},bold] 󰖪 offline }"

# ========================================
# PRODUCTIVITY ENHANCEMENTS  
# ========================================
# Additional tmux optimizations for cyberpunk workflow

# Enhanced copy mode bindings with cyberpunk flair
# bind-key -T copy-mode-vi Enter send-keys -X copy-pipe-and-cancel "pbcopy"
# bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "pbcopy"

# Cyberpunk-themed popup window styling (for your existing popups)
set -g popup-style "fg=#{@thm_text},bg=#{@thm_surface0}"
set -g popup-border-style "fg=#{@thm_cyan}"

# Enhanced window switching with visual feedback
# bind-key -r Tab select-window -t :+
# bind-key -r BTab select-window -t :-
