local palette = {}

-- Base cyberpunk color palette inspired by neon cityscapes
palette.colors = {
  -- Background colors (deep dark with subtle tech vibes)
  bg = "#0a0e14",
  bg_dark = "#060a0f",
  bg_float = "#0e1419",
  bg_sidebar = "#0c1016",
  bg_statusline = "#1a1f25",
  bg_visual = "#2a1f3d",

  -- Foreground colors
  fg = "#e0e6f0",
  fg_dark = "#b4bcc8",
  fg_gutter = "#3b4458",

  -- Neon accent colors (the cyberpunk soul)
  neon_pink = "#ff007f",
  neon_cyan = "#00ffff",
  neon_green = "#00ff41",
  neon_purple = "#bf00ff",
  neon_orange = "#ff8800",
  neon_blue = "#0080ff",
  neon_yellow = "#ffff00",

  -- Semantic colors using neon palette
  error = "#ff007f",
  warning = "#ff8800",
  info = "#00ffff",
  hint = "#bf00ff",
  success = "#00ff41",

  -- Git colors
  git_add = "#00ff41",
  git_change = "#ff8800",
  git_delete = "#ff007f",
  git_ignore = "#3b4458",

  -- Syntax highlighting
  comment = "#6a7b9a",
  constant = "#ff007f",
  string = "#00ff41",
  character = "#00ff41",
  number = "#bf00ff",
  boolean = "#bf00ff",
  float = "#bf00ff",
  identifier = "#e0e6f0",
  function_name = "#00ffff",
  statement = "#ff007f",
  conditional = "#ff8800",
  repeat_key = "#ff8800",
  label = "#0080ff",
  operator = "#00ffff",
  keyword = "#ff007f",
  exception = "#ff007f",
  preproc = "#bf00ff",
  include = "#bf00ff",
  define = "#bf00ff",
  title = "#00ffff",
  macro = "#bf00ff",
  type = "#0080ff",
  storage_class = "#ff8800",
  structure = "#0080ff",
  typedef = "#0080ff",
  special = "#ffff00",
  special_char = "#ff8800",
  tag = "#ff007f",
  delimiter = "#e0e6f0",
  special_comment = "#00ffff",
  debug = "#ff007f",

  -- UI Elements
  border = "#2a3441",
  cursor = "#00ffff",
  cursor_line = "#1a1f25",
  selection = "#2a1f3d",
  search = "#ff8800",
  match_paren = "#00ffff",

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
