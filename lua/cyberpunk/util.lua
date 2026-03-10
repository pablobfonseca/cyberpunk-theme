local util = {}
local palette = require('cyberpunk.palette')

-- Convert hex to RGB
function util.hex_to_rgb(hex)
  hex = hex:gsub("#", "")
  return tonumber("0x" .. hex:sub(1, 2)), tonumber("0x" .. hex:sub(3, 4)), tonumber("0x" .. hex:sub(5, 6))
end

-- Darken a color by a given amount (0-1)
function util.darken(hex, amount)
  local r, g, b = util.hex_to_rgb(hex)
  r = math.floor(r * (1 - amount))
  g = math.floor(g * (1 - amount))
  b = math.floor(b * (1 - amount))
  return string.format("#%02x%02x%02x", r, g, b)
end

-- Lighten a color by a given amount (0-1)
function util.lighten(hex, amount)
  local r, g, b = util.hex_to_rgb(hex)
  r = math.min(255, math.floor(r + (255 - r) * amount))
  g = math.min(255, math.floor(g + (255 - g) * amount))
  b = math.min(255, math.floor(b + (255 - b) * amount))
  return string.format("#%02x%02x%02x", r, g, b)
end

-- Apply highlight groups
function util.highlight(groups)
  for group, colors in pairs(groups) do
    if type(colors) == "string" then
      vim.api.nvim_command("highlight! link " .. group .. " " .. colors)
    else
      local style = colors.style and "gui=" .. colors.style or "gui=NONE"
      local fg = colors.fg and "guifg=" .. colors.fg or "guifg=NONE"
      local bg = colors.bg and "guibg=" .. colors.bg or "guibg=NONE"
      local sp = colors.sp and "guisp=" .. colors.sp or ""
      
      local hl = "highlight " .. group .. " " .. style .. " " .. fg .. " " .. bg .. " " .. sp
      vim.api.nvim_command(hl)
    end
  end
end

-- Set terminal colors
function util.terminal()
  local colors = palette.colors.terminal
  
  -- Set Neovim terminal colors
  vim.g.terminal_color_0 = colors.black
  vim.g.terminal_color_1 = colors.red
  vim.g.terminal_color_2 = colors.green
  vim.g.terminal_color_3 = colors.yellow
  vim.g.terminal_color_4 = colors.blue
  vim.g.terminal_color_5 = colors.magenta
  vim.g.terminal_color_6 = colors.cyan
  vim.g.terminal_color_7 = colors.white
  vim.g.terminal_color_8 = colors.bright_black
  vim.g.terminal_color_9 = colors.bright_red
  vim.g.terminal_color_10 = colors.bright_green
  vim.g.terminal_color_11 = colors.bright_yellow
  vim.g.terminal_color_12 = colors.bright_blue
  vim.g.terminal_color_13 = colors.bright_magenta
  vim.g.terminal_color_14 = colors.bright_cyan
  vim.g.terminal_color_15 = colors.bright_white
end

-- Helper for creating highlight with fallback
function util.hl(group, opts)
  return { [group] = opts }
end

-- Load highlight groups
function util.load_highlights(highlights)
  for group, opts in pairs(highlights) do
    util.highlight(util.hl(group, opts))
  end
end

return util