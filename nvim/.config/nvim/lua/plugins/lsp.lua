return {
	"VonHeikemen/lsp-zero.nvim",
	dependencies = {
		{ "neovim/nvim-lspconfig" },
		{ "saghen/blink.cmp" },
		{ "folke/neoconf.nvim" },
		{
			"folke/lazydev.nvim",
			ft = "lua", -- only load on lua files
			opts = {
				library = {
					-- See the configuration section for more details
					-- Load luvit types when the `vim.uv` word is found
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
			},
		},

		{ "williamboman/mason.nvim" },
		{ "williamboman/mason-lspconfig.nvim" },
		{ "jay-babu/mason-nvim-dap.nvim" },
		{ "zapling/mason-conform.nvim" },
		{
			"MysticalDevil/inlay-hints.nvim",
			event = "LspAttach",
			config = function()
				require("inlay-hints").setup()
			end,
		},
		{
			"j-hui/fidget.nvim",
			event = "LspAttach",
			opts = {},
		},
		{ "nvimdev/lspsaga.nvim" },
		{ "rachartier/tiny-inline-diagnostic.nvim" },
	},
	event = { "VeryLazy" },
	config = function()
		vim.diagnostic.config({ virtual_text = false })
		-- 打算启用的语言服务列表
		local servers = {
			"marksman", -- 任意标题<space>aw打开code action可以开头生成目录；超链接可以链接到同一个git项目的其他markdown文件#指定标题<space>h可以预览
			"lua_ls",
			"pyright",
			"rust_analyzer",
			"clangd",
		}
		local dap = {}
		local conform = {}
		-- lsp_zero的相关配置
		local lsp_zero = require("lsp-zero")
		lsp_zero.on_attach(function(client, bufnr)
			lsp_zero.default_keymaps({ buffer = bufnr })
			local opts = { buffer = bufnr, noremap = true }
			vim.keymap.set("n", "H", "<cmd>Lspsaga hover_doc<cr>", opts) -- <space>h显示提示文档
			vim.keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<cr>", opts) -- gd跳转到定义的位置
			vim.keymap.set("n", "go", "<cmd>Lspsaga goto_type_definition<cr>", opts) -- go跳转到变量类型定义的位置
			vim.keymap.set("n", "gr", vim.lsp.buf.references, opts) -- gr跳转到引用了对应变量或函数的位置
			vim.keymap.set("n", "<leader>lrn", "<cmd>Lspsaga rename<cr>", opts) -- <space>rn变量重命名
			--vim.keymap.set({ 'n', 'x' }, '<leader>f', function() vim.lsp.buf.format({ async = true }) end, opts) -- <space>f进行代码格式化
			vim.keymap.set("n", "<leader>law", "<cmd>Lspsaga code_action<cr>", opts) -- <space>aw可以在出现警告或错误的地方打开建议的修复方法
			vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, opts) -- <space>d浮动窗口显示所在行警告或错误信息
			vim.keymap.set("n", "<leader>l-", "<cmd>Lspsaga diagnostic_jump_prev<cr>", opts) -- <space>-跳转到上一处警告或错误的地方
			vim.keymap.set("n", "<leader>l=", "<cmd>Lspsaga diagnostic_jump_next<cr>", opts) -- <space>+跳转到下一处警告或错误的地方
		end)
		-- “符号栏”是行号旁边的装订线中的一个空格。当一行中出现警告或错误时，Neovim 会向您显示一个字母
		lsp_zero.set_sign_icons({
			error = "✘",
			warn = "▲",
			hint = "⚑",
			info = "»",
		})
		-- 通过mason来自动安装语言服务器，可以在对应的代码运行LspIstall来安装可用的语言服务器
		-- Default configuration
		require("tiny-inline-diagnostic").setup({
			-- Style preset for diagnostic messages
			-- Available options:
			-- "modern", "classic", "minimal", "powerline",
			-- "ghost", "simple", "nonerdfont", "amongus"
			preset = "modern",

			transparent_bg = false, -- Set the background of the diagnostic to transparent

			hi = {
				error = "DiagnosticError", -- Highlight group for error messages
				warn = "DiagnosticWarn", -- Highlight group for warning messages
				info = "DiagnosticInfo", -- Highlight group for informational messages
				hint = "DiagnosticHint", -- Highlight group for hint or suggestion messages
				arrow = "NonText", -- Highlight group for diagnostic arrows

				-- Background color for diagnostics
				-- Can be a highlight group or a hexadecimal color (#RRGGBB)
				background = "CursorLine",

				-- Color blending option for the diagnostic background
				-- Use "None" or a hexadecimal color (#RRGGBB) to blend with another color
				mixing_color = "None",
			},

			options = {
				-- Display the source of the diagnostic (e.g., basedpyright, vsserver, lua_ls etc.)
				show_source = false,

				-- Use icons defined in the diagnostic configuration
				use_icons_from_diagnostic = false,

				-- Add messages to diagnostics when multiline diagnostics are enabled
				-- If set to false, only signs will be displayed
				add_messages = true,

				-- Time (in milliseconds) to throttle updates while moving the cursor
				-- Increase this value for better performance if your computer is slow
				-- or set to 0 for immediate updates and better visual
				throttle = 20,

				-- Minimum message length before wrapping to a new line
				softwrap = 30,

				-- Configuration for multiline diagnostics
				-- Can either be a boolean or a table with the following options:
				--  multilines = {
				--      enabled = false,
				--      always_show = false,
				-- }
				-- If it set as true, it will enable the feature with this options:
				--  multilines = {
				--      enabled = true,
				--      always_show = false,
				-- }
				multilines = {
					-- Enable multiline diagnostic messages
					enabled = false,

					-- Always show messages on all lines for multiline diagnostics
					always_show = false,
				},
				-- Display all diagnostic messages on the cursor line
				show_all_diags_on_cursorline = false,

				-- Enable diagnostics in Insert mode
				-- If enabled, it is better to set the `throttle` option to 0 to avoid visual artifacts
				enable_on_insert = false,

				-- Enable diagnostics in Select mode (e.g when auto inserting with Blink)
				enable_on_select = false,

				overflow = {
					-- Manage how diagnostic messages handle overflow
					-- Options:
					-- "wrap" - Split long messages into multiple lines
					-- "none" - Do not truncate messages
					-- "oneline" - Keep the message on a single line, even if it's long
					mode = "wrap",

					-- Trigger wrapping to occur this many characters earlier when mode == "wrap".
					-- Increase this value appropriately if you notice that the last few characters
					-- of wrapped diagnostics are sometimes obscured.
					padding = 0,
				},

				-- Configuration for breaking long messages into separate lines
				break_line = {
					-- Enable the feature to break messages after a specific length
					enabled = false,

					-- Number of characters after which to break the line
					after = 30,
				},

				-- Custom format function for diagnostic messages
				-- Example:
				-- format = function(diagnostic)
				--     return diagnostic.message .. " [" .. diagnostic.source .. "]"
				-- end
				format = nil,

				virt_texts = {
					-- Priority for virtual text display
					priority = 2048,
				},

				-- Filter diagnostics by severity
				-- Available severities:
				-- vim.diagnostic.severity.ERROR
				-- vim.diagnostic.severity.WARN
				-- vim.diagnostic.severity.INFO
				-- vim.diagnostic.severity.HINT
				severity = {
					vim.diagnostic.severity.ERROR,
					vim.diagnostic.severity.WARN,
					vim.diagnostic.severity.INFO,
					vim.diagnostic.severity.HINT,
				},

				-- Events to attach diagnostics to buffers
				-- You should not change this unless the plugin does not work with your configuration
				overwrite_events = nil,
			},
			disabled_ft = {}, -- List of filetypes to disable the plugin
		})
		require("lspsaga").setup()
		require("lazydev").setup()
		require("neoconf").setup()
		require("mason").setup({})
		require("mason-conform").setup({ ensure_installed = conform })
		require("mason-nvim-dap").setup({ ensure_installed = dap })
		require("mason-lspconfig").setup({ ensure_installed = servers })
		-- cmp相关配置，通过for读取servers列表循环批量激活语言服务
		local lspconfig = require("lspconfig")
		for _, lsp in ipairs(servers) do
			lspconfig[lsp].setup({
				capabilities = require("blink.cmp").get_lsp_capabilities(),
				settings = {
					Lua = {
						hint = { -- Lua开启hints
							enable = true, -- necessary
						},
					},
				},
			})
		end
	end,
}
