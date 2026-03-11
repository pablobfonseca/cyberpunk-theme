local util = {}
local palette = require('cyberpunk.palette')

--- Convert hex color string to RGB components.
--- @param hex string Hex color (e.g. "#ff007f")
--- @return number, number, number
function util.hex_to_rgb(hex)
  hex = hex:gsub("#", "")
  return tonumber("0x" .. hex:sub(1, 2)),
    tonumber("0x" .. hex:sub(3, 4)),
    tonumber("0x" .. hex:sub(5, 6))
end

--- Darken a hex color by a factor (0 = unchanged, 1 = black).
--- @param hex string
--- @param amount number 0-1
--- @return string
function util.darken(hex, amount)
  local r, g, b = util.hex_to_rgb(hex)
  r = math.floor(r * (1 - amount))
  g = math.floor(g * (1 - amount))
  b = math.floor(b * (1 - amount))
  return string.format("#%02x%02x%02x", r, g, b)
end

--- Lighten a hex color by a factor (0 = unchanged, 1 = white).
--- @param hex string
--- @param amount number 0-1
--- @return string
function util.lighten(hex, amount)
  local r, g, b = util.hex_to_rgb(hex)
  r = math.min(255, math.floor(r + (255 - r) * amount))
  g = math.min(255, math.floor(g + (255 - g) * amount))
  b = math.min(255, math.floor(b + (255 - b) * amount))
  return string.format("#%02x%02x%02x", r, g, b)
end

--- Resolve a `style` value into nvim_set_hl-compatible keys.
--- Accepts:
---   table  → { italic = true }        → returned as-is
---   string → "bold" or "bold,italic"   → split and converted to { bold = true, italic = true }
--- @param style string|table|nil
--- @return table
local function resolve_style(style)
  if type(style) == "table" then
    return style
  end
  if type(style) == "string" then
    local out = {}
    for token in style:gmatch("[^,]+") do
      out[token:match("^%s*(.-)%s*$")] = true
    end
    return out
  end
  return {}
end

--- Apply highlight groups via nvim_set_hl.
--- Each value is either a link target (string) or a table of highlight attrs.
--- The special `style` key is expanded into boolean flags (bold, italic, etc.).
--- @param groups table<string, string|table>
function util.highlight(groups)
  for group, hl in pairs(groups) do
    if type(hl) == "string" then
      vim.api.nvim_set_hl(0, group, { link = hl })
    else
      local opts = {}
      for k, v in pairs(hl) do
        if k == "style" then
          for sk, sv in pairs(resolve_style(v)) do
            opts[sk] = sv
          end
        else
          opts[k] = v
        end
      end
      vim.api.nvim_set_hl(0, group, opts)
    end
  end
end

--- Set terminal ANSI colors from the palette.
function util.terminal()
  local colors = palette.colors.terminal

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

return util
