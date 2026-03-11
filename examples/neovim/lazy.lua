-- Cyberpunk theme setup with lazy.nvim
-- Place in ~/.config/nvim/lua/plugins/cyberpunk.lua

-- Using Lazy's opts property (recommended)
return {
	"pablobfonseca/cyberpunk-theme",
	priority = 1000,
	lazy = false,
	opts = {
		style = "storm", -- "storm" | "night" | "neon"
		transparent = false,
		styles = {
			comments = { italic = true },
			keywords = { bold = true },
			functions = { bold = true },
			variables = {},
			sidebars = "dark", -- "dark" | "transparent"
			floats = "dark", -- "dark" | "transparent"
		},
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
			flash = true,
			leap = true,
			toggleterm = true,
		},
		lsp = {
			ui = true, -- enable cyberpunk diagnostic signs (█▓▒░), virtual text, floats
		},
		-- Override individual colors
		-- on_colors = function(colors)
		--   colors.bg = "#000000"
		-- end,
		-- Override highlight groups
		-- on_highlights = function(hl, colors)
		--   hl.Comment = { fg = colors.comment, italic = true }
		-- end,
	},
	config = function(_, opts)
		require("cyberpunk").setup(opts)
		vim.cmd("colorscheme cyberpunk")
	end,
}

-- Minimal setup (uses defaults)
-- return {
-- 	"pablobfonseca/cyberpunk-theme",
-- 	priority = 1000,
-- 	lazy = false,
-- 	config = function()
-- 		vim.cmd("colorscheme cyberpunk")
-- 	end,
-- }

-- Using a style variant directly
-- return {
-- 	"pablobfonseca/cyberpunk-theme",
-- 	priority = 1000,
-- 	lazy = false,
-- 	config = function()
-- 		vim.cmd("colorscheme cyberpunk-neon")
-- 	end,
-- }

-- LSP float borders (automatic with lsp.ui = true)
-- Hover gets cyan borders, signature help gets pink borders.
-- Override per-float borders in your keymaps if needed:
--
-- local lsp = require("cyberpunk.lsp")
-- vim.keymap.set("n", "K", function()
--   vim.lsp.buf.hover { border = lsp.hover_border }
-- end)
