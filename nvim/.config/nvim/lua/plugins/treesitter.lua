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
			---@type TSConfig : modules
			ensure_installed = language,
			sync_install = false,
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
				disable = {},
				-- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
				disable = function(lang, buf)
					local max_filesize = 100 * 1024 -- 100 KB
					local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
					if ok and stats and stats.size > max_filesize then
						return true
					end
				end,
			},
			ignore_install = {},
		})
		require("hlargs").setup()
		require("ts_context_commentstring").setup()
	end,
}
