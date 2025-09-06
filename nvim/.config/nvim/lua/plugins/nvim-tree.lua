return {
	"nvim-tree/nvim-tree.lua",
	keys = {
		{ "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "nvim-tree open" },
	},
	config = function()
		require("nvim-tree").setup({
			sort_by = "case_sensitive",
			view = {
				width = 30,
			},
			renderer = {
				group_empty = true,
			},
			filters = {
				dotfiles = false,
			},
			actions = {
				open_file = { quit_on_open = true },
			},
		})
	end,
}
