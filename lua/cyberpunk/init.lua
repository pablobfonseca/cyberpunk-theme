local M = {}

local palette = require('cyberpunk.palette')
local util = require('cyberpunk.util')

M.config = {
  -- Customize the theme
  style = "storm", -- storm, night, neon
  transparent = false,
  terminal_colors = true,
  styles = {
    comments = { italic = true },
    keywords = { bold = true },
    functions = { bold = true },
    variables = {},
    sidebars = "dark",
    floats = "dark",
  },
  day_brightness = 0.3,
  hide_inactive_statusline = false,
  dim_inactive = false,
  lualine_bold = false,
  
  -- Plugin integrations
  plugins = {
    -- Modern Neovim plugins
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
    
    -- Code completion
    cmp = true,
    blink_cmp = true,
    
    -- Git
    fugitive = true,
    
    -- File explorers
    oil = true,
    
    -- Modern editing
    flash = true,
    leap = true,
    
    -- Terminal
    toggleterm = true,
  }
}

-- Apply user configuration
function M.setup(opts)
  opts = opts or {}
  M.config = vim.tbl_deep_extend("force", M.config, opts)
  
  -- Set up the colorscheme
  if M.config.terminal_colors then
    util.terminal()
  end
end

-- Load the colorscheme
function M.load()
  -- Clear any existing highlights
  if vim.g.colors_name then
    vim.cmd("hi clear")
  end
  
  if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
  end
  
  vim.opt.background = "dark"
  vim.g.colors_name = "cyberpunk"
  
  -- Apply highlights
  local colors = palette.colors
  local highlights = require('cyberpunk.highlights')
  local groups = highlights.setup(colors, M.config)
  
  util.highlight(groups)
  
  -- Set terminal colors
  if M.config.terminal_colors then
    util.terminal()
  end
end

-- Apply colorscheme with configuration
function M.colorscheme()
  M.load()
end

-- Toggle transparency
function M.toggle_transparent()
  M.config.transparent = not M.config.transparent
  M.load()
  print("Cyberpunk transparency: " .. (M.config.transparent and "enabled" or "disabled"))
end

-- Get current colors (for external use)
function M.get_colors()
  return require('cyberpunk.palette').colors
end

-- Export configuration
M.colors = M.get_colors

return M