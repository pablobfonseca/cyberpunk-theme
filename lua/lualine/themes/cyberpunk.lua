local colors = require('cyberpunk').get_colors()

local cyberpunk = {}

cyberpunk.normal = {
  a = { fg = colors.bg, bg = colors.neon_cyan, gui = 'bold' },
  b = { fg = colors.fg, bg = colors.bg_statusline },
  c = { fg = colors.fg_dark, bg = colors.bg_dark },
}

cyberpunk.insert = {
  a = { fg = colors.bg, bg = colors.neon_green, gui = 'bold' },
}

cyberpunk.visual = {
  a = { fg = colors.bg, bg = colors.neon_purple, gui = 'bold' },
}

cyberpunk.replace = {
  a = { fg = colors.bg, bg = colors.neon_orange, gui = 'bold' },
}

cyberpunk.command = {
  a = { fg = colors.bg, bg = colors.neon_pink, gui = 'bold' },
}

cyberpunk.terminal = {
  a = { fg = colors.bg, bg = colors.neon_yellow, gui = 'bold' },
}

cyberpunk.inactive = {
  a = { fg = colors.fg_dark, bg = colors.bg_dark },
  b = { fg = colors.fg_dark, bg = colors.bg_dark },
  c = { fg = colors.fg_dark, bg = colors.bg_dark },
}

return cyberpunk
