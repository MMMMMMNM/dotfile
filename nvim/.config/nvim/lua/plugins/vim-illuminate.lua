return {
	"RRethy/vim-illuminate",
	event = "BufNew",
	config = function()
		require("illuminate").configure({})
	end,
}
