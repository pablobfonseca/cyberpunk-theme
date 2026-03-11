local M = {}

local palette = require('cyberpunk.palette')
local util = require('cyberpunk.util')

M.config = {
  transparent = false,
  terminal_colors = true,
  styles = {
    comments = { italic = true },
    keywords = { bold = true },
    functions = { bold = true },
    variables = {},
  },
  dim_inactive = false,

  -- Plugin integrations
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
  }
}

--- Merge user options into the default config.
--- @param opts table|nil
function M.setup(opts)
  M.config = vim.tbl_deep_extend("force", M.config, opts or {})
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

  local highlights = require('cyberpunk.highlights')
  local groups = highlights.setup(palette.colors, M.config)
  util.highlight(groups)

  if M.config.terminal_colors then
    util.terminal()
  end
end

--- Shorthand entry point used by colors/cyberpunk.vim.
function M.colorscheme()
  M.load()
end

--- Toggle transparency and reload.
function M.toggle_transparent()
  M.config.transparent = not M.config.transparent
  M.load()
  vim.notify("Cyberpunk transparency: " .. (M.config.transparent and "on" or "off"))
end

--- Return the raw palette colors (for lualine themes, statusline, etc.).
--- @return table
function M.get_colors()
  return palette.colors
end

M.colors = M.get_colors

return M
