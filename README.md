# 🌃 Cyberpunk Theme

> A neon-soaked, electric aesthetic theme suite for Neovim, tmux, and Ghostty

**Welcome to the grid.** This theme brings the electric, neon-drenched aesthetics of cyberpunk to your development environment. Built with modern Neovim APIs and designed for the latest terminal technologies.

## ✨ Features

- 🎨 **Full spectrum neon palette** - Electric pinks, cyan blues, matrix greens, and purple hazes
- ⚡ **Modern Neovim support** - Built for Neovim 0.9+ with Lua, Treesitter, and LSP semantic tokens
- 🔧 **Extensive plugin support** - 20+ popular plugins styled with cyberpunk aesthetics
- 🖥️ **Terminal suite** - Matching themes for tmux and Ghostty
- 🎯 **True color support** - Designed for modern terminals with full RGB support
- 🌐 **Semantic highlighting** - LSP-aware syntax highlighting with meaningful color coding

## 🎨 Color Palette

```
🌃 Backgrounds:    #0a0e14 (main) • #060a0f (dark) • #0e1419 (float)
💫 Foregrounds:    #e0e6f0 (main) • #b4bcc8 (dark) • #3b4458 (gutter)

🔴 Neon Pink:      #ff007f    🔵 Electric Blue:   #0080ff
🟢 Matrix Green:   #00ff41    🟣 Neon Purple:     #bf00ff
🟡 Cyber Yellow:   #ffff00    🟠 Neon Orange:     #ff8800
🔷 Electric Cyan:  #00ffff    ⚪ Bright White:    #ffffff
```

## 🚀 Installation

### Neovim Theme

Using [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  'pablobfonseca/cyberpunk-theme',
  priority = 1000,
  config = function()
    require('cyberpunk').setup({
      -- Your config here
    })
    vim.cmd('colorscheme cyberpunk')
  end,
}
```

Using [packer.nvim](https://github.com/wbthomason/packer.nvim):

```lua
use {
  'pablobfonseca/cyberpunk-theme',
  config = function()
    require('cyberpunk').setup()
    vim.cmd('colorscheme cyberpunk')
  end
}
```

Manual installation:

```bash
git clone https://github.com/pablobfonseca/cyberpunk-theme.git ~/.config/nvim/pack/plugins/start/cyberpunk-theme
```

### Tmux Theme

**Basic Setup:**

```bash
# Add to your ~/.tmux.conf
source-file ~/path/to/cyberpunk-theme/extras/tmux/cyberpunk.tmux
```

**Features:**

- 🔍 **Enhanced dim panels** - inactive panes dimmed for better focus
- ⚡ **Cyberpunk color variables** - compatible with `#{@thm_*}` style configs
- 🎯 **Active pane highlighting** with cyberpunk cyan borders
- 📊 **Optional enhancements** available (CPU color coding, enhanced battery display, etc.)

**Reload tmux config:**

```bash
tmux source-file ~/.tmux.conf
```

### Ghostty Theme

Copy the config to your Ghostty config directory:

```bash
# Linux/macOS
cp extras/ghostty/cyberpunk ~/.config/ghostty/themes/

# Then add to your main ghostty config:
theme = cyberpunk
```

## ⚙️ Configuration

### Neovim Setup

```lua
require('cyberpunk').setup({
  -- Theme variant
  style = "storm", -- storm, night, neon

  -- Transparency
  transparent = false,

  -- Terminal colors
  terminal_colors = true,

  -- Style customization
  styles = {
    comments = { italic = true },
    keywords = { bold = true },
    functions = { bold = true },
    variables = {},
    sidebars = "dark", -- dark, transparent
    floats = "dark", -- dark, transparent
  },

  -- Plugin integrations
  plugins = {
    -- Core editing
    treesitter = true,
    lsp = true,

    -- File exploration
    telescope = true,
    nvim_tree = true,
    neo_tree = true,
    oil = true,

    -- UI enhancements
    bufferline = true,
    lualine = true,
    alpha = true,
    which_key = true,
    notify = true,
    noice = true,

    -- Code completion
    cmp = true,
    blink_cmp = true,

    -- Git integration
    gitsigns = true,
    fugitive = true,

    -- Navigation
    flash = true,
    leap = true,

    -- Terminal
    toggleterm = true,

    -- Code display
    indent_blankline = true,
  }
})
```

### Color Customization

```lua
-- Access colors directly
local colors = require('cyberpunk.palette').colors

-- Override specific colors
require('cyberpunk').setup({
  on_colors = function(colors)
    colors.neon_pink = "#ff0080"  -- Custom neon pink
    colors.bg = "#000000"         -- Pure black background
  end,

  on_highlights = function(highlights, colors)
    highlights.Comment = { fg = colors.neon_cyan, style = "italic" }
    highlights.Function = { fg = colors.neon_green, style = "bold" }
  end,
})
```

## 🔌 Plugin Support

The theme includes first-class support for:

### 🔍 **Navigation & Search**

- Telescope - Enhanced fuzzy finding with neon highlights
- Flash/Leap - Electric motion highlighting
- Which-key - Glowing key binding hints

### 📁 **File Management**

- Nvim-tree - Cyberpunk file explorer styling
- Neo-tree - Modern file tree with neon accents
- Oil.nvim - Directory editing with electric highlights

### ⌨️ **Code Editing**

- Treesitter - Semantic syntax highlighting
- LSP - Intelligent code highlighting
- nvim-cmp/Blink.cmp - Futuristic completion menus
- Indent Blankline - Subtle indentation guides

### 🎨 **UI Enhancement**

- Lualine - Electric statusline
- Bufferline - Neon buffer tabs
- Alpha - Cyberpunk dashboard
- Notify - Glowing notifications
- Noice - Enhanced UI components

### 🔧 **Git Integration**

- GitSigns - Visual git status with neon colors
- Fugitive - Git workflow enhancement

### 💻 **Terminal**

- ToggleTerm - Floating terminal with themed borders
- Built-in terminal - Full color palette support

## 🎯 Language Support

Optimized highlighting for:

- **JavaScript/TypeScript** - Framework-aware highlighting
- **Python** - Enhanced syntax distinction
- **Rust** - Memory-safe neon aesthetics
- **Go** - Clean, efficient color coding
- **Lua** - Neovim configuration highlighting
- **C/C++** - System-level programming clarity
- **HTML/CSS** - Web development with style
- **Markdown** - Documentation with flair
- **JSON/YAML** - Configuration file clarity
- **Bash/Zsh** - Shell scripting enhancement

## 🚀 Performance

- ⚡ **Lazy loading** - Only loads highlights when needed
- 🎨 **Optimized palette** - Efficient color calculations
- 💾 **Memory efficient** - Minimal runtime overhead
- 🔄 **Fast switching** - Quick theme changes

## 🤝 Contributing

Contributions welcome! Areas of focus:

- 🎨 Additional color variants
- 🔌 More plugin integrations
- 🐛 Bug fixes and improvements
- 📖 Documentation enhancements
- 🖥️ Additional terminal support

### Development Setup

```bash
git clone https://github.com/pablobfonseca/cyberpunk-theme.git
cd cyberpunk-theme

# Test the theme
ln -sf $(pwd) ~/.config/nvim/pack/dev/start/cyberpunk-theme
nvim +CyberpunkReload
```

## 📸 Screenshots

> _Screenshots showing the theme in action across different file types and plugins_

**Lua Configuration** - Neovim setup with enhanced syntax highlighting
**Python Development** - Modern syntax with LSP integration  
**Terminal Workflow** - tmux and Ghostty with matching aesthetics
**Plugin Showcase** - Telescope, tree view, and completion menus

## 🛠️ Terminal Requirements

For the best experience:

- **True color support** (24-bit color)
- **Modern terminal emulator** (Ghostty, Alacritty, Kitty, iTerm2, etc.)
- **Neovim 0.9+** for full feature support
- **Nerd Font** for icon support (optional but recommended)

## 📦 Similar Themes

Inspired by and compatible with the cyberpunk aesthetic family:

- Tokyo Night - Clean, modern dark theme
- Synthwave '84 - Retro neon aesthetics
- Monokai Pro - Enhanced Monokai variants
- Dracula - Popular vampire theme

## 📝 License

MIT License - Feel free to hack the gibson with this theme!

## 🌟 Acknowledgments

- Inspired by cyberpunk culture and neon city aesthetics
- Built on the excellent foundation of modern Neovim theming
- Thanks to the amazing plugin ecosystem that makes this possible

---

**"The future is now. Make it neon."** ⚡🌃
