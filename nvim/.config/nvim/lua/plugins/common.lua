return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = { preset = "helix" }, --modern classic helix
	},
	{
		"nvim-zh/colorful-winsep.nvim",
		event = { "WinLeave" },
		config = true,
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = {},
  -- stylua: ignore
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
	},
	{
		"echasnovski/mini.pairs",
		event = "InsertEnter",
		opts = {},
	},

	{
		"0x00-ketsu/autosave.nvim",
		-- lazy-loading on event
		event = { "InsertLeave", "TextChanged" },
		config = function()
			require("autosave").setup({
				enable = true,
				prompt = {
					enable = true,
					style = "stdout",
					message = function()
						return "Autosave: saved at " .. vim.fn.strftime("%H:%M:%S")
					end,
				},
				events = { "InsertLeave", "TextChanged" },
				conditions = {
					exists = true,
					modifiable = true,
					filename_is_not = {},
					filetype_is_not = {},
				},
				write_all_buffers = false,
				debounce_delay = 135,
			})
		end,
	},
	{
		"vladdoster/remember.nvim",
		opts = {},
	},
	{
		"RRethy/vim-illuminate",
		event = "BufNew",
		config = function()
			require("illuminate").configure({})
		end,
	},
	{
		"alexghergh/nvim-tmux-navigation",
		config = function()
			local nvim_tmux_nav = require("nvim-tmux-navigation")

			nvim_tmux_nav.setup({
				disable_when_zoomed = true, -- defaults to false
			})

			vim.keymap.set("n", "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
			vim.keymap.set("n", "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
			vim.keymap.set("n", "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
			vim.keymap.set("n", "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
			vim.keymap.set("n", "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive)
			vim.keymap.set("n", "<C-Space>", nvim_tmux_nav.NvimTmuxNavigateNext)
		end,
	},
	{
		"OXY2DEV/helpview.nvim",
		lazy = false,
	},
	{
		"sitiom/nvim-numbertoggle",
		event = "BufNew",
	},
	{
		"rmagatti/auto-session",
		lazy = false,
		keys = {
			{ "<leader>as", "<cmd>SessionRestore<cr>", desc = "Restore Session" },
			{ "<leader>aS", "<cmd>AutoSession search", desc = "Search Session" },
			{ "<leader>aD", "<cmd>AutoSession delete", desc = "Delete Session" },
		},
		---enables autocomplete for opts
		---@module "auto-session"
		---@type AutoSession.Config
		opts = {
			suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
			auto_save = true, -- Enables/disables auto saving session on exit
			auto_restore = false, -- Enables/disables auto restoring session on start
			auto_create = true, -- Enables/disables auto creating new session files. Can take a function that should return true/false if a new session file should be created or not
			-- log_level = 'debug',
		},
	},
}
