return {
	{
		"saghen/blink.cmp",
		dependencies = {
			"rafamadriz/friendly-snippets",
			"mikavilpas/blink-ripgrep.nvim",
			"folke/snacks.nvim",
			"Kaiser-Yang/blink-cmp-avante",
		},
		event = "InsertEnter",
		version = "*",
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			-- Disable for some filetypes
			enabled = function()
				return not vim.tbl_contains({}, vim.bo.filetype)
					and vim.bo.buftype ~= "prompt"
					and vim.b.completion ~= false
			end,

			-- Disable cmdline
			cmdline = {
				enabled = false,
			},

			completion = {
				keyword = { range = "full" },

				-- Disable auto brackets
				-- NOTE: some LSPs may add auto brackets themselves anyway
				accept = { auto_brackets = { enabled = true } },

				-- Don't select by default, auto insert on selection
				list = { selection = { preselect = false, auto_insert = true } },

				menu = {
					-- Don't automatically show the completion menu
					auto_show = true,
				},

				-- Show documentation when selecting a completion item
				documentation = { auto_show = true, auto_show_delay_ms = 500 },

				-- Display a preview of the selected item on the current line
				ghost_text = { enabled = true },
			},

			sources = {
				-- Remove 'buffer' if you don't want text completions, by default it's only enabled when LSP returns no items
				default = { "avante", "lsp", "ripgrep", "path", "snippets", "buffer" },
				providers = {
					ripgrep = {
						module = "blink-ripgrep",
						name = "Ripgrep",
						-- the options below are optional, some default values are shown
						---@module "blink-ripgrep"
						---@type blink-ripgrep.Options
						opts = {},
					},
					avante = {
						module = "blink-cmp-avante",
						name = "Avante",
						opts = {
							-- options for blink-cmp-avante
						},
					},
				},
			},
			-- Blink.cmp uses a Rust fuzzy matcher by default for frecency, proximity bonsu, typo resistance and
			-- significantly better performance. A lua implementation has been included as well.
			-- See the fuzzy documentation for more information
			fuzzy = { implementation = "lua" },

			-- Use a preset for snippets, check the snippets documentation for more information
			snippets = { preset = "default" },

			-- Experimental signature help support
			signature = { enabled = true },
		},
	},
}
