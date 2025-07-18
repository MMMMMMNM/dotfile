return {
	"folke/trouble.nvim",
	cmd = { "Trouble" },
	opts = {
		modes = {
			lsp = {
				win = { position = "right" },
			},
		},
	},
	keys = {
		{ "<leader>tx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
		{ "<leader>tX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
		{ "<leader>ts", "<cmd>Trouble symbols toggle<cr>", desc = "Symbols (Trouble)" },
		{ "<leader>tS", "<cmd>Trouble lsp toggle<cr>", desc = "LSP references/definitions/... (Trouble)" },
		{ "<leader>tL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
		{ "<leader>tQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
		{
			"tq",
			function()
				if require("trouble").is_open() then
					require("trouble").prev({ skip_groups = true, jump = true })
				else
					local ok, err = pcall(vim.cmd.cprev)
					if not ok then
						vim.notify(err, vim.log.levels.ERROR)
					end
				end
			end,
			desc = "Previous Trouble/Quickfix Item",
		},
		{
			"]q",
			function()
				if require("trouble").is_open() then
					require("trouble").next({ skip_groups = true, jump = true })
				else
					local ok, err = pcall(vim.cmd.cnext)
					if not ok then
						vim.notify(err, vim.log.levels.ERROR)
					end
				end
			end,
			desc = "Next Trouble/Quickfix Item",
		},
	},
}
