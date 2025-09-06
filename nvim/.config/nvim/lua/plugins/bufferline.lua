return {
	{
		"akinsho/bufferline.nvim",
		event = "BufHidden",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline").setup({
				options = {
					mode = "buffers",
					themable = true,
					numbers = "ordinal",
					truncate_names = true, -- whether or not tab names should be truncated
					indicator = "▎",
					buffer_close_icon = "󰅖",
					modified_icon = "● ",
					close_icon = " ",
					left_trunc_marker = " ",
					right_trunc_marker = " ",
					diagnostic = "nvim_lsp",
					diagnostics_update_in_insert = true,
					diagnostics_update_on_event = true,
					diagnostics_indicator = function(count, level, diagnostics_dict, context)
						local s = " "
						for e, n in pairs(diagnostics_dict) do
							local sym = e == "error" and " " or (e == "warning" and " " or " ")
							s = s .. n .. sym
						end
						return s
					end,

					offsets = {
						{
							filetype = "NvimTree",
							text = "File Explorer",
							text_align = "left",
							separator = true,
						},
					},
					close_icons = true,

					separator_style = { "|", "|" },

					hover = {
						enabled = true,
						delay = 200,
						reveal = { "close" },
					},
				},
			})
		end,
	},
}
