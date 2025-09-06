return {
	{
		"jiangxue-analysis/nvim.comment-hide",
		name = "comment-hide",
		lazy = false,
		keys = {
			{ "<leader>sS", "<cmd>CommentHideSave<CR>", desc = "Comment: Save (strip comments)" },
			{ "<leader>sr", "<cmd>CommentHideRestore<CR>", desc = "Comment: Restore from backup" },
		},
		config = function()
			require("comment-hide").setup({
				gitignore = true, -- Automatically add .annotations/ to .gitignore.
			})
		end,
	},
	{
		"folke/todo-comments.nvim",
		event = "BufNew",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			signs = true, -- show icons in the signs column
			sign_priority = 8, -- sign priority
			-- keywords recognized as todo comments
			keywords = {
				FIX = {
					icon = " ", -- icon used for the sign, and in search results
					color = "error", -- can be a hex color, or a named color (see below)
					alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
					-- signs = false, -- configure signs for some keywords individually
				},
				TODO = { icon = " ", color = "info" },
				HACK = { icon = " ", color = "warning" },
				WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
				PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
				NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
				TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
			},
			gui_style = {
				fg = "NONE", -- The gui style to use for the fg highlight group.
				bg = "BOLD", -- The gui style to use for the bg highlight group.
			},
			merge_keywords = true, -- when true, custom keywords will be merged with the defaults
			-- highlighting of the line containing the todo comment
			-- * before: highlights before the keyword (typically comment characters)
			-- * keyword: highlights of the keyword
			-- * after: highlights after the keyword (todo text)
			highlight = {
				multiline = true, -- enable multine todo comments
				multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
				multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
				before = "", -- "fg" or "bg" or empty
				keyword = "wide", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
				after = "fg", -- "fg" or "bg" or empty
				pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
				comments_only = true, -- uses treesitter to match keywords in comments only
				max_line_len = 400, -- ignore lines longer than this
				exclude = {}, -- list of file types to exclude highlighting
			},
			-- list of named colors where we try to extract the guifg from the
			-- list of highlight groups or use the hex color if hl not found as a fallback
			colors = {
				error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
				warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
				info = { "DiagnosticInfo", "#2563EB" },
				hint = { "DiagnosticHint", "#10B981" },
				default = { "Identifier", "#7C3AED" },
				test = { "Identifier", "#FF00FF" },
			},
			search = {
				command = "rg",
				args = {
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
				},
				-- regex that will be used to match keywords.
				-- don't replace the (KEYWORDS) placeholder
				pattern = [[\b(KEYWORDS):]], -- ripgrep regex
				-- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
			},
		},
	},
	{
		"folke/ts-comments.nvim",
		opts = {
			lang = {
				astro = "<!-- %s -->",
				axaml = "<!-- %s -->",
				blueprint = "// %s",
				c = "// %s",
				c_sharp = "// %s",
				clojure = { ";; %s", "; %s" },
				cpp = "// %s",
				cs_project = "<!-- %s -->",
				cue = "// %s",
				fsharp = "// %s",
				fsharp_project = "<!-- %s -->",
				gleam = "// %s",
				glimmer = "{{! %s }}",
				graphql = "# %s",
				handlebars = "{{! %s }}",
				hcl = "# %s",
				html = "<!-- %s -->",
				hyprlang = "# %s",
				ini = "; %s",
				ipynb = "# %s",
				javascript = {
					"// %s", -- default commentstring when no treesitter node matches
					"/* %s */",
					call_expression = "// %s", -- specific commentstring for call_expression
					jsx_attribute = "// %s",
					jsx_element = "{/* %s */}",
					jsx_fragment = "{/* %s */}",
					spread_element = "// %s",
					statement_block = "// %s",
				},
				kdl = "// %s",
				php = "// %s",
				rego = "# %s",
				rescript = "// %s",
				rust = { "// %s", "/* %s */" },
				sql = "-- %s",
				styled = "/* %s */",
				svelte = "<!-- %s -->",
				templ = {
					"// %s",
					component_block = "<!-- %s -->",
				},
				terraform = "# %s",
				tsx = {
					"// %s", -- default commentstring when no treesitter node matches
					"/* %s */",
					call_expression = "// %s", -- specific commentstring for call_expression
					jsx_attribute = "// %s",
					jsx_element = "{/* %s */}",
					jsx_fragment = "{/* %s */}",
					spread_element = "// %s",
					statement_block = "// %s",
				},
				twig = "{# %s #}",
				typescript = { "// %s", "/* %s */" }, -- langs can have multiple commentstrings
				vue = "<!-- %s -->",
				xaml = "<!-- %s -->",
			},
		},
		event = "BufNew",
		enabled = vim.fn.has("nvim-0.10.0") == 1,
	},
}
