return {
	"stevearc/overseer.nvim",
	event = "BufNew",
	config = function()
		require("overseer").setup({})
	end,
}
