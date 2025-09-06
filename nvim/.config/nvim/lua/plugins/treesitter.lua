return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = { "m-demare/hlargs.nvim", "JoosepAlviste/nvim-ts-context-commentstring", "windwp/nvim-ts-autotag" },
	event = "BufNew",
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
		require("hlargs").setup()
		require("ts_context_commentstring").setup()
		require("nvim-ts-autotag").setup({
			opts = {
				-- Defaults
				enable_close = true, -- Auto close tags
				enable_rename = true, -- Auto rename pairs of tags
				enable_close_on_slash = false, -- Auto close on trailing </
			},
			-- Also override individual filetype configs, these take priority.
			-- Empty by default, useful if one of the "opts" global settings
			-- doesn't work well in a specific filetype
			per_filetype = {
				["html"] = {
					enable_close = false,
				},
			},
		})
	end,
}
