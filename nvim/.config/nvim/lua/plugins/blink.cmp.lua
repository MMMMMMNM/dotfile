return {
	"saghen/blink.cmp",
	dependencies = { "rafamadriz/friendly-snippets", "mikavilpas/blink-ripgrep.nvim", "folke/snacks.nvim" },
	event = "InsertEnter",
	version = "*",
	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept, C-n/C-p for up/down)
		-- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys for up/down)
		-- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
		--
		-- All presets have the following mappings:
		-- C-space: Open menu or open docs if already open
		-- C-e: Hide menu
		-- C-k: Toggle signature help
		--
		-- See the full "keymap" documentation for information on defining your own keymap.
		keymap = {
			-- set to 'none' to disable the 'default' preset
			preset = "none",

			["<Up>"] = { "select_prev", "fallback" },
			["<Down>"] = { "select_next", "fallback" },

			-- disable a keymap from the preset
			--['<C-e>'] = {},

			-- show with a list of providers
			["<C-space>"] = {
				function(cmp)
					cmp.show({ providers = { "snippets" } })
				end,
			},

			-- control whether the next command will be run when using a function
			["<C-n>"] = {
				function(cmp)
					if some_condition then
						return
					end -- runs the next command
					return true -- doesn't run the next command
				end,
				"select_next",
			},
		},
		appearance = {
			-- Sets the fallback highlight groups to nvim-cmp's highlight groups
			-- Useful for when your theme doesn't support blink.cmp
			-- Will be removed in a future release
			use_nvim_cmp_as_default = true,
			-- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			-- Adjusts spacing to ensure icons are aligned
			nerd_font_variant = "mono",
		},

		-- Default list of enabled providers defined so that you can extend it
		-- elsewhere in your config, without redefining it, due to `opts_extend`
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},

		-- Blink.cmp uses a Rust fuzzy matcher by default for typo resistance and significantly better performance
		-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
		-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
		--
		-- See the fuzzy documentation for more information
		fuzzy = { implementation = "prefer_rust_with_warning" },
	},
	opts_extend = { "sources.default" },
}
