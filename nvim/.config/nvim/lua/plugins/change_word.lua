return {
	"tobser/btoggle.nvim",
	config = function()
		require("btoggle").setup({
			["bind"] = "unbind",
			["connect"] = "disconnect",
			["input"] = "output",
			["insert"] = "delete",
			["install"] = "uninstall",
			["left"] = "right",
			["Left"] = "Right",
			["link"] = "unlink",
			["load"] = "unload",
			["lock"] = "unlock",
			["max"] = "min",
			["maximum"] = "minimum",

			["open"] = "close",
			["off"] = "on",

			["read"] = "write",

			["true"] = "false",
			["True"] = "False",
			["false"] = "true",
			["False"] = "True",
		})
	end,
}
