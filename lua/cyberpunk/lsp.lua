local M = {}

local function make_border(hl)
  return {
    { "┌", hl }, { "─", hl }, { "┐", hl }, { "│", hl },
    { "┘", hl }, { "─", hl }, { "└", hl }, { "│", hl },
  }
end

--- Pre-built border tables for use in keymaps (0.11+).
--- Example: vim.lsp.buf.hover { border = require("cyberpunk.lsp").hover_border }
M.hover_border = make_border("LspHoverBorder")
M.signature_border = make_border("LspSignatureHelpBorder")

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
      border = make_border("FloatBorder"),
      source = true,
      max_width = 80,
      max_height = 20,
    }

    if vim.fn.has("nvim-0.11") == 1 then
      local orig_hover = vim.lsp.buf.hover
      vim.lsp.buf.hover = function(o)
        o = vim.tbl_extend("keep", o or {}, {
          border = M.hover_border,
          max_width = 80,
        })
        return orig_hover(o)
      end

      local orig_sig = vim.lsp.buf.signature_help
      vim.lsp.buf.signature_help = function(o)
        o = vim.tbl_extend("keep", o or {}, {
          border = M.signature_border,
          max_width = 80,
        })
        return orig_sig(o)
      end
    else
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
        vim.lsp.handlers.hover, {
          border = M.hover_border,
          max_width = 80,
        }
      )
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help, {
          border = M.signature_border,
          max_width = 80,
        }
      )
    end
  end

  -- Apply user overrides last
  config = vim.tbl_deep_extend("force", config, opts.override)

  vim.diagnostic.config(config)

  if opts.float then
    M._style_cmp()
  end
end

--- Override nvim-cmp window borders when the plugin is loaded.
function M._style_cmp()
  local ok, cmp = pcall(require, "cmp")
  if not ok then
    return
  end

  local border = make_border("CmpBorder")
  local whl = "Normal:NormalFloat,FloatBorder:CmpBorder,CursorLine:Visual,Search:None"

  cmp.setup {
    window = {
      completion = { border = border, winhighlight = whl },
      documentation = { border = border, winhighlight = whl },
    },
  }
end

return M
