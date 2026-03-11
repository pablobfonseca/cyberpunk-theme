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
    M._defer_style_cmp()
  end
end

local kind_icons = {
  Text = "󰉿",
  Method = "󰆧",
  Function = "󰊕",
  Constructor = "",
  Field = "󰜢",
  Variable = "󰀫",
  Class = "󰠱",
  Interface = "",
  Module = "",
  Property = "󰜢",
  Unit = "󰑭",
  Value = "󰎠",
  Enum = "",
  Keyword = "󰌋",
  Snippet = "",
  Color = "󰏘",
  File = "󰈙",
  Reference = "󰈇",
  Folder = "󰉋",
  EnumMember = "",
  Constant = "󰏿",
  Struct = "󰙅",
  Event = "",
  Operator = "󰆕",
  TypeParameter = "",
}

--- Apply cyberpunk styling to nvim-cmp (borders + kind icons).
function M._apply_cmp_style()
  local ok, cmp = pcall(require, "cmp")
  if not ok then
    return false
  end

  local border = make_border("CmpBorder")
  local whl = "Normal:NormalFloat,FloatBorder:CmpBorder,CursorLine:Visual,Search:None"

  local has_devicons, devicons = pcall(require, "nvim-web-devicons")

  cmp.setup {
    formatting = {
      fields = { "kind", "abbr", "menu" },
      format = function(_, vim_item)
        if has_devicons and (vim_item.kind == "File" or vim_item.kind == "Folder") then
          local icon, hl = devicons.get_icon(vim_item.abbr, nil, { default = true })
          if icon then
            vim_item.kind = icon .. " "
            vim_item.kind_hl_group = hl
            return vim_item
          end
        end
        vim_item.kind = (kind_icons[vim_item.kind] or "") .. " "
        return vim_item
      end,
    },
    window = {
      completion = { border = border, winhighlight = whl },
      documentation = { border = border, winhighlight = whl },
    },
  }
  return true
end

--- Defer cmp styling until the plugin is actually loaded.
function M._defer_style_cmp()
  -- Try immediately (cmp might already be loaded)
  if M._apply_cmp_style() then
    return
  end
  -- Wait for lazy-loaded cmp
  vim.api.nvim_create_autocmd("InsertEnter", {
    once = true,
    callback = function()
      vim.schedule(M._apply_cmp_style)
    end,
  })
end

return M
