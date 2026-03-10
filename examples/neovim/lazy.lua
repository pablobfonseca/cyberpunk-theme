-- Cyberpunk theme setup with lazy.nvim
-- Place in ~/.config/nvim/lua/plugins/cyberpunk.lua

return {
  'shikamarunaraclaw/cyberpunk-theme',
  priority = 1000, -- Load before other plugins
  config = function()
    require('cyberpunk').setup({
      -- Enable transparency for floating windows
      transparent = false,
      
      -- Customize syntax highlighting styles  
      styles = {
        comments = { italic = true },
        keywords = { bold = true },
        functions = { bold = true },
        variables = {},
      },
      
      -- Enable/disable plugin integrations
      plugins = {
        -- Core
        treesitter = true,
        lsp = true,
        
        -- Popular plugins
        telescope = true,
        nvim_tree = true,
        neo_tree = true,
        bufferline = true,
        lualine = true,
        alpha = true,
        which_key = true,
        notify = true,
        
        -- Completion
        cmp = true,
        blink_cmp = true,
        
        -- Git
        gitsigns = true,
        
        -- Navigation  
        flash = true,
        leap = true,
        
        -- Terminal
        toggleterm = true,
        
        -- UI
        indent_blankline = true,
      }
    })
    
    -- Set the colorscheme
    vim.cmd('colorscheme cyberpunk')
  end,
}