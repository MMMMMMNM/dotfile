vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
local keymap = vim.keymap
local opt = { noremap = true }
--keymap.set("mode","key","commmnd")
--keymap.set("","","")
--keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>")
keymap.set("n", "H", "<cmd>BufferLineCyclePrev<CR>", opt)
keymap.set("n", "L", "<cmd>BufferLineCycleNext<CR>", opt)

keymap.set("n", "<leader>sw", "<cmd>vsplit<cr>", opt)
keymap.set("n", "<leader>ss", "<cmd>split<cr>", opt)

keymap.set("n", "<leader>aa", "<cmd>ASToggle<cr>", opt)
