return {
	"MagicDuck/grug-far.nvim",
	keys = { { "<leader>fg", "<cmd>GrugFar<cr>", desc = " Use grug_far to replace word" } },
	config = function()
		require("grug-far").setup({})
	end,
}
