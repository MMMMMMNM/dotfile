return {
	"stevearc/conform.nvim",
	event = "FileWriteCmd",
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				-- Conform will run multiple formatters sequentially
				python = { "black" },
				cpp = { "clang-format" },
				-- You can customize some of the format options for the filetype (:help conform.format)
				rust = { "rustfmt", lsp_format = "fallback" },
				bash = { "beautysh" },
				markdown = { "mdformat" },
				cmake = { "cmakelang" },
				-- Conform will run the first available formatter
				--javascript = { "prettierd", "prettier", stop_after_first = true },
			},
		})
	end,
}
