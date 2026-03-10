# Cyberpunk tmux Integration Guide

## For Existing Sophisticated tmux Configurations

This guide helps integrate the cyberpunk theme with existing advanced tmux setups while preserving your custom status bar and functionality.

## 📋 Quick Integration Steps

### 1. Update Your tmux.conf

Replace this line in your `~/.config/tmux/tmux.conf`:
```bash
# OLD: 
source-file ~/code/nvim/cyberpunk-theme/extras/tmux/cyberpunk.tmux

# NEW:
source-file ~/code/nvim/cyberpunk-theme/extras/tmux/cyberpunk-advanced.tmux
```

### 2. Remove Conflicting Styles (Optional)

Comment out or remove these lines if present:
```bash
# Remove these Catppuccin overrides:
# set -g pane-border-style "fg=#313244"
# set -g pane-active-border-style "fg=#fab387"  
# set -g window-style "bg=#11111b,fg=#6c7086"
# set -g window-active-style "bg=#1e1e2e,fg=#cdd6f4"
```

### 3. Reload tmux
```bash
tmux source-file ~/.config/tmux/tmux.conf
```

## 🎯 What This Preserves

✅ **Your Status Bar Layout** - Exact same format and positioning  
✅ **All Functionality** - CPU, battery, online status, session info  
✅ **Dim Panel Feature** - Inactive panes remain dimmed  
✅ **Key Bindings** - All your custom bindings unchanged  
✅ **Plugin Integration** - All plugins continue working  

## 🌃 What This Adds

🎨 **Cyberpunk Colors** - Your theme variables now use cyberpunk palette  
⚡ **Enhanced Focus** - Active pane gets subtle highlighting  
🔧 **Better Borders** - Refined pane border colors  
📊 **Optional Enhancements** - Available in the theme file  

## 🔍 Color Mapping

Your existing variables are now cyberpunk-themed:

| Variable | Cyberpunk Color | Usage |
|----------|----------------|--------|
| `#{@thm_bg}` | `#0a0e14` | Background |
| `#{@thm_peach}` | `#f59e0b` | Current window |
| `#{@thm_green}` | `#5fb3a1` | Success states |
| `#{@thm_red}` | `#f87171` | Alerts, errors |
| `#{@thm_cyan}` | `#64d9ef` | Highlights |
| `#{@thm_purple}` | `#a78bfa` | Special states |

## 🚀 Optional Enhancements

The theme file includes commented optional enhancements:

### Enhanced CPU Display
Color-coded CPU usage (green → yellow → red)

### Enhanced Battery Display  
Smoother color transitions for battery levels

### Enhanced Session Display
Git branch context in session info

### Enhanced Zoom Indicator
More prominent zoom state display

### Enhanced Online Status
Better icons and connectivity display

**To enable:** Uncomment the desired sections in `cyberpunk-advanced.tmux`

## 🎨 Dim Panel Feature Details

The cyberpunk theme enhances your dim panel feature:

- **Inactive panes:** Dark background (`#0a0e14`) with muted text
- **Active pane:** Slightly lighter background (`#1a1f25`) with bright text
- **Border highlight:** Active pane gets cyberpunk cyan border
- **Focus clarity:** Maintains your existing focus workflow

## 🔧 Customization

### Adjust Colors
Edit the color variables at the top of `cyberpunk-advanced.tmux`:
```bash
accent_cyan='#64d9ef'     # Primary accent
accent_green='#5fb3a1'    # Success states
accent_orange='#f59e0b'   # Current window
# ... etc
```

### Status Bar Tweaks
Your existing status bar format works unchanged, but you can:
- Enable optional enhancements selectively
- Adjust status update interval (currently 5 seconds)
- Modify pane display timing

## 🐛 Troubleshooting

### Status Bar Looks Wrong
1. Verify the theme file path is correct
2. Check for conflicting color overrides
3. Ensure all required plugins are loaded

### Colors Don't Match Terminal
1. Verify terminal supports true color (`COLORTERM=truecolor`)
2. Check tmux color settings (`set -ga terminal-overrides`)
3. Reload tmux configuration

### Dim Panels Not Working
1. Ensure no conflicting window-style settings
2. Check terminal background color support
3. Verify tmux version supports window styling

## 📊 Performance Notes

- **Status update:** Optimized to 5-second intervals
- **Color calculations:** Minimal overhead
- **Plugin compatibility:** All existing plugins preserved
- **Memory usage:** No significant increase

## 🎯 Result

You get:
- **Same sophisticated status bar** you already have
- **Same dim panel functionality** for focus
- **Cyberpunk aesthetic** throughout
- **Optional enhancements** when you want them
- **Zero workflow disruption**

Perfect integration of cyberpunk style with your existing advanced tmux setup! 🌃⚡