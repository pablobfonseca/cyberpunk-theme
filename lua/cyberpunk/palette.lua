local palette = {}

-- Base cyberpunk color palette inspired by neon cityscapes
palette.colors = {
  -- Background colors (deep dark with subtle tech vibes)
  bg = "#0a0e14",        -- Deep dark blue-black
  bg_dark = "#060a0f",   -- Even darker for contrast
  bg_float = "#0e1419",  -- Floating windows
  bg_sidebar = "#0c1016", -- Sidebars
  bg_statusline = "#1a1f25", -- Status line
  bg_visual = "#2a1f3d", -- Visual selection (dark purple)
  
  -- Foreground colors
  fg = "#e0e6f0",        -- Main text (cool white)
  fg_dark = "#b4bcc8",   -- Darker text
  fg_gutter = "#3b4458", -- Line numbers
  
  -- Neon accent colors (the cyberpunk soul)
  neon_pink = "#ff007f",    -- Hot pink/magenta
  neon_cyan = "#00ffff",    -- Electric cyan
  neon_green = "#00ff41",   -- Matrix green
  neon_purple = "#bf00ff",  -- Electric purple
  neon_orange = "#ff8800",  -- Neon orange
  neon_blue = "#0080ff",    -- Electric blue
  neon_yellow = "#ffff00",  -- Bright yellow
  
  -- Semantic colors using neon palette
  error = "#ff007f",        -- Neon pink for errors
  warning = "#ff8800",      -- Neon orange for warnings  
  info = "#00ffff",         -- Cyan for info
  hint = "#bf00ff",         -- Purple for hints
  success = "#00ff41",      -- Green for success
  
  -- Git colors
  git_add = "#00ff41",      -- Green
  git_change = "#ff8800",   -- Orange
  git_delete = "#ff007f",   -- Pink
  git_ignore = "#3b4458",   -- Muted
  
  -- Syntax highlighting
  comment = "#6a7b9a",      -- Muted blue-grey
  constant = "#ff007f",     -- Neon pink
  string = "#00ff41",       -- Matrix green
  character = "#00ff41",    -- Green
  number = "#bf00ff",       -- Purple
  boolean = "#bf00ff",      -- Purple
  float = "#bf00ff",        -- Purple
  identifier = "#e0e6f0",   -- Default fg
  function_name = "#00ffff", -- Cyan
  statement = "#ff007f",    -- Pink
  conditional = "#ff8800",  -- Orange
  repeat_key = "#ff8800",   -- Orange
  label = "#neon_blue",     -- Blue
  operator = "#00ffff",     -- Cyan
  keyword = "#ff007f",      -- Pink
  exception = "#ff007f",    -- Pink
  preproc = "#bf00ff",      -- Purple
  include = "#bf00ff",      -- Purple
  define = "#bf00ff",       -- Purple
  title = "#00ffff",        -- Cyan
  macro = "#bf00ff",        -- Purple
  type = "#0080ff",         -- Blue
  storage_class = "#ff8800", -- Orange
  structure = "#0080ff",    -- Blue
  typedef = "#0080ff",      -- Blue
  special = "#ffff00",      -- Yellow
  special_char = "#ff8800", -- Orange
  tag = "#ff007f",          -- Pink
  delimiter = "#e0e6f0",    -- Default fg
  special_comment = "#00ffff", -- Cyan
  debug = "#ff007f",        -- Pink
  
  -- UI Elements
  border = "#2a3441",       -- Subtle borders
  cursor = "#00ffff",       -- Cyan cursor
  cursor_line = "#1a1f25",  -- Subtle highlight
  selection = "#2a1f3d",    -- Purple selection
  search = "#ff8800",       -- Orange search highlights
  match_paren = "#00ffff",  -- Cyan matching parens
  
  -- Terminal colors (ANSI)
  terminal = {
    black = "#0a0e14",
    red = "#ff007f",
    green = "#00ff41", 
    yellow = "#ffff00",
    blue = "#0080ff",
    magenta = "#bf00ff",
    cyan = "#00ffff",
    white = "#e0e6f0",
    bright_black = "#3b4458",
    bright_red = "#ff4499",
    bright_green = "#44ff77",
    bright_yellow = "#ffff66",
    bright_blue = "#4499ff", 
    bright_magenta = "#dd66ff",
    bright_cyan = "#66ffff",
    bright_white = "#ffffff",
  }
}

return palette