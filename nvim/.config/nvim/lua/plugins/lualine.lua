return {
	"nvim-lualine/lualine.nvim",
	events = {
		"WinEnter",
		"BufEnter",
		"BufWritePost",
		"SessionLoadPost",
		"FileChangedShellPost",
		"VimResized",
		"Filetype",
		"CursorMoved",
		"CursorMovedI",
		"ModeChanged",
	},
	dependencies = { "nvim-tree/nvim-web-devicons", { "Hashino/speed.nvim", opts = { float_buffer = false } } },
	config = function()
		require("lualine").setup({
			options = {
				icons_enabled = true,
				--theme = "catppuccin",
				theme = "auto",
				show_colors = true,
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" },
					winbar = {},
				},
				ignore_focus = {},
				always_divide_middle = true,
				always_show_tabline = true,
				globalstatus = false,
				refresh = {
					statusline = 100,
					tabline = 100,
					winbar = 100,
				},
			},
			sections = {
				lualine_a = {
					"mode",
				},
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { "filename", require("speed").current },
				lualine_x = {
				  	"encoding",
					"fileformat",
					"filetype",
				},
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			winbar = {},
			inactive_winbar = {},
			extensions = { "fzf", "nvim-tree", "toggleterm", "trouble", "lazy", "mason", "nvim-dap-ui" },
		})
    end
}
