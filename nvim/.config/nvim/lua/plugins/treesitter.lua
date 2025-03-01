return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = { "m-demare/hlargs.nvim", "JoosepAlviste/nvim-ts-context-commentstring" },
	event = "BufNew",
	config = function()
		-- 要安装高亮的语言直接加入括号即可，把sync_install设置为true下次进入vim自动安装，语言列表查看treesitter的github
		-- 或者执行:TSInstall <language_to_install>
		local language = {
			"python",
			"lua",
			"markdown",
			"bash",
			"java",
			"vimdoc",
		}
		require("nvim-treesitter.configs").setup({
			---@type TSConfig
			-- A list of parser names, or "all"
			ensure_installed = language,
			-- Install parsers synchronously (only applied to `ensure_installed`)
			sync_install = true,
			-- List of parsers to ignore installing (for "all")
			ignore_install = {},
			highlight = {
				enable = true,

				disable = {},

				additional_vim_regex_highlighting = false,
			},
		})
		require("hlargs").setup()
		require("ts_context_commentstring").setup()
	end,
}
