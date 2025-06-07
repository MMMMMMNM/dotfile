return {
	"nvim-treesitter/nvim-treesitter",
	--	dependencies = { "m-demare/hlargs.nvim", "JoosepAlviste/nvim-ts-context-commentstring" },
	--event = "BufNew",
	config = function()
		-- 要安装高亮的语言直接加入括号即可，把sync_install设置为true下次进入vim自动安装，语言列表查看treesitter的github
		-- 或者执行:TSInstall <language_to_install>
		local language = {
			"cpp",
			"lua",
			"vim",
			"vimdoc",
			"query",
			"elixir",
			"heex",
			"javascript",
			"html",
		}
		require("nvim-treesitter.configs").setup({
			ensure_installed = language,
			ignore_install = {},
			highlights = {
				enable = true,
			},
		})
		-- require("hlargs").setup()
		-- require("ts_context_commentstring").setup()
	end,
}
