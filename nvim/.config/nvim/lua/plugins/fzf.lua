return {
	"ibhagwan/fzf-lua",
	-- optional for icon support
	dependencies = { "nvim-tree/nvim-web-devicons" },
	-- or if using mini.icons/mini.nvim
	-- dependencies = { "echasnovski/mini.icons" },
	cmd = { "FzfLua" },
	keys = {
		{ "<leader>fw", "<cmd>FzfLua grep<cr>", desc = "found word" },
		{ "<leader>fo", "<cmd>FzfLua oldfiles<cr>", desc = "found oldfiles" },
		{ "<leader>ff", "<cmd>FzfLua files<cr>", desc = "found file" },
		{ "<leader><space>", "<cmd>FzfLua buffers<cr>", desc = "found buffers" },
		{ "<leader>f?", "<cmd>FzfLua helptags<cr>", desc = "found helptags" },
	},
	opts = {},
}
