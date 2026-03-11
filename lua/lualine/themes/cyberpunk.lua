local function build()
  local colors = require('cyberpunk').get_colors()
  return {
    normal = {
      a = { fg = colors.bg, bg = colors.neon_cyan, gui = 'bold' },
      b = { fg = colors.fg, bg = colors.bg_statusline },
      c = { fg = colors.fg_dark, bg = colors.bg_dark },
    },
    insert = {
      a = { fg = colors.bg, bg = colors.neon_green, gui = 'bold' },
    },
    visual = {
      a = { fg = colors.bg, bg = colors.neon_purple, gui = 'bold' },
    },
    replace = {
      a = { fg = colors.bg, bg = colors.neon_orange, gui = 'bold' },
    },
    command = {
      a = { fg = colors.bg, bg = colors.neon_pink, gui = 'bold' },
    },
    terminal = {
      a = { fg = colors.bg, bg = colors.neon_yellow, gui = 'bold' },
    },
    inactive = {
      a = { fg = colors.fg_dark, bg = colors.bg_dark },
      b = { fg = colors.fg_dark, bg = colors.bg_dark },
      c = { fg = colors.fg_dark, bg = colors.bg_dark },
    },
  }
end

return setmetatable({}, {
  __index = function(_, key)
    return build()[key]
  end,
})
