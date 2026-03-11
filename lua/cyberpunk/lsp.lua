local M = {}

local defaults = {
  signs = true,
  virtual_text = true,
  float = true,
  override = {},
}

--- Configure vim.diagnostic and LSP handlers with cyberpunk styling.
--- @param opts table|nil
function M.setup(opts)
  opts = vim.tbl_deep_extend("force", defaults, opts or {})

  local config = {}

  if opts.signs then
    config.signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = "█",
        [vim.diagnostic.severity.WARN] = "▓",
        [vim.diagnostic.severity.INFO] = "▒",
        [vim.diagnostic.severity.HINT] = "░",
      },
    }
  end

  if opts.virtual_text then
    config.virtual_text = {
      prefix = "▌",
      spacing = 2,
      severity = { min = vim.diagnostic.severity.HINT },
    }
  end

  config.underline = true
  config.update_in_insert = false
  config.severity_sort = true

  if opts.float then
    config.float = {
      border = "rounded",
      source = true,
      max_width = 80,
      max_height = 20,
    }
  end

  -- Apply user overrides last
  config = vim.tbl_deep_extend("force", config, opts.override)

  vim.diagnostic.config(config)
end

return M
