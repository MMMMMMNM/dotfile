return {
	{
		"echasnovski/mini.pairs",
		event = "InsertEnter",
		opts = {},
	},
	{
		"echasnovski/mini.move",
		event = "BufNew",
		version = false,
		config = function()
			require("mini.move").setup()
		end,
	},
}
