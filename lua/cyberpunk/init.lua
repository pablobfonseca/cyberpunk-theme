local M = {}

local palette = require('cyberpunk.palette')
local util = require('cyberpunk.util')

M.config = {
  style = "storm",         -- "storm" | "night" | "neon"
  transparent = false,
  terminal_colors = true,
  styles = {
    comments = { italic = true },
    keywords = { bold = true },
    functions = { bold = true },
    variables = {},
    sidebars = "dark",     -- "dark" | "transparent"
    floats = "dark",       -- "dark" | "transparent"
  },
  dim_inactive = false,
  lsp = {
    ui = false,  -- opt-in: configure diagnostic signs, virtual text, floats
  },
  on_colors = nil,         -- function(colors) end
  on_highlights = nil,     -- function(highlights, colors) end

  plugins = {
    treesitter = true,
    lsp = true,
    telescope = true,
    nvim_tree = true,
    neo_tree = true,
    bufferline = true,
    lualine = true,
    gitsigns = true,
    indent_blankline = true,
    alpha = true,
    which_key = true,
    notify = true,
    noice = true,
    cmp = true,
    blink_cmp = true,
    fugitive = true,
    oil = true,
    flash = true,
    leap = true,
    toggleterm = true,
  },
}

--- Merge user options into the default config.
--- @param opts table|nil
function M.setup(opts)
  M.config = vim.tbl_deep_extend("force", M.config, opts or {})
  if vim.g.colors_name == "cyberpunk" then
    M.load()
  end
end

--- Load the colorscheme: clear existing highlights, apply palette + config.
function M.load()
  if vim.g.colors_name then
    vim.cmd("hi clear")
  end
  if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
  end

  vim.opt.background = "dark"
  vim.g.colors_name = "cyberpunk"

  -- Resolve colors for the active style variant
  local colors = palette.get(M.config.style)

  -- Allow users to mutate the color table before highlights are built
  if type(M.config.on_colors) == "function" then
    M.config.on_colors(colors)
  end

  local highlights = require('cyberpunk.highlights')
  local groups = highlights.setup(colors, M.config)

  -- Allow users to override / add highlight groups after the full set is built
  if type(M.config.on_highlights) == "function" then
    M.config.on_highlights(groups, colors)
  end

  util.highlight(groups)

  if M.config.terminal_colors then
    util.terminal(colors)
  end

  if M.config.lsp and M.config.lsp.ui then
    require('cyberpunk.lsp').setup(M.config.lsp)
  end
end

--- Shorthand entry point used by colors/*.vim files.
function M.colorscheme()
  M.load()
end

--- Toggle transparency and reload.
function M.toggle_transparent()
  M.config.transparent = not M.config.transparent
  M.load()
  vim.notify("Cyberpunk transparency: " .. (M.config.transparent and "on" or "off"))
end

--- Return the resolved colors for the active style (respects on_colors).
--- NOTE: on_colors mutations are NOT applied here; this returns the raw palette.
--- For the post-mutation colors, inspect inside on_highlights.
--- @return table
function M.get_colors()
  return palette.get(M.config.style)
end

M.colors = M.get_colors

return M
