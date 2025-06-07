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

keymap.set("n", "<leader>am", "<cmd>ASToggle<cr>", opt)

keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)", opt)
keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)", opt)
keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)", opt)
keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)", opt)

keymap.set("n", "<c-p>", "<Plug>(YankyPreviousEntry)", opt)
keymap.set("n", "<c-n>", "<Plug>(YankyNextEntry)", opt)
