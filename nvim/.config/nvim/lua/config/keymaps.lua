local map = function(Mode, Key, Cmd, Desc)
	vim.keymap.set(Mode, Key, Cmd, Desc)
end
local opt = { noremap = true }
map("n", "L", "<cmd>BufferLineCyceNext<CR>") --change buffer
map("n", "<leader>sw", "<cmd>vsplit<cr>", opt) -- vsplit
map("n", "<leader>ss", "<cmd>split<cr>", opt) -- split

map("n", "<leader>o", "<cmd>OverseerOpen<cr>", opt) -- Overseer Open Windows
map("n", "<F5>", "<cmd>OverseerRun<cr>", opt) -- Overseer Run Code

map("n", "<leader>am", "<cmd>ASToggle<cr>", opt)

map({ "n", "i", "v" }, "<Left>", "<Nop>")
map({ "n", "i", "v" }, "<Right>", "<Nop>")
map({ "n", "i", "v" }, "<Up>", "<Nop>")
map({ "n", "i", "v" }, "<Down>", "<Nop>")

map("n", "<leader>fs", ":Namu symbols<cr>", {
	desc = "Jump to LSP symbol",
	silent = true,
})
map("n", "<leader>fm", ":Namu workspace<cr>", {
	desc = "LSP Symbols - Workspace",
	silent = true,
})

map("n", "<leader>aa", require("btoggle").toggle, { desc = " change words" })
