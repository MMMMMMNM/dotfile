return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "auto", -- latte, frappe, macchiato, mocha
				background = { -- :h background
					light = "latte",
					dark = "mocha",
				},
				transparent_background = true, -- disables setting the background color.
				show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
				term_colors = true, -- sets terminal colors (e.g. `g:terminal_color_0`)
				dim_inactive = {
					enabled = false, -- dims the background color of inactive window
					shade = "dark",
					percentage = 0.15, -- percentage of the shade to apply to the inactive window
				},
				no_italic = false, -- Force no italic
				no_bold = false, -- Force no bold
				no_underline = false, -- Force no underline
				styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
					comments = { "italic" }, -- Change the style of comments
					conditionals = { "italic" },
					loops = {},
					functions = {},
					keywords = {},
					strings = {},
					variables = {},
					numbers = {},
					booleans = {},
					properties = {},
					types = {},
					operators = {},
					-- miscs = {}, -- Uncomment to turn off hard-coded styles
				},
				color_overrides = {},
				custom_highlights = {},
				default_integrations = true,
				integrations = {
					blink_cmp = true,
					gitsigns = true,
					nvimtree = true,
					treesitter = true,
					notify = true,
					noice = true,
					mini = {
						enabled = true,
						indentscope_color = "",
					},
					fzf = true,
					flash = true,
					which_key = true,
					colorful_winsep = {
						enabled = true,
						color = "blue",
					},
					indent_blankline = {
						enabled = true,
						scope_color = "", -- catppuccin color (eg. `lavender`) Default: text
						colored_indent_levels = true,
					},
					fidget = true,
					dropbar = {
						enabled = false,
						color_mode = false, -- enable color for kind's texts, not just kind's icons
					},
					ts_rainbow = true,
					illuminate = {
						enabled = true,
						lsp = true,
					},
					mason = true,
					semantic_tokens = true,
					lsp_saga = true,
					-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
				},
			})

			-- setup must be called before loading
			vim.cmd.colorscheme("catppuccin")
		end,
	},
	{
		-- "folke/tokyonight.nvim",
		-- lazy = false,
		-- priority = 1000,
		-- opts = {},
	},
}
