return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"smiteshp/nvim-navic",
		"catppuccin",
	},
	config = function()
		local lualine = require("lualine")
		local custom_catppuccin = require("lualine.themes.catppuccin-mocha")
		local colors = require("catppuccin.palettes").get_palette("mocha")

		custom_catppuccin.normal.b.bg = colors.base
		custom_catppuccin.normal.c.bg = colors.base

		custom_catppuccin.inactive.a.bg = colors.base
		custom_catppuccin.inactive.b.bg = colors.base
		custom_catppuccin.inactive.c.bg = colors.base
		custom_catppuccin.inactive.a.fg = colors.overlay0
		custom_catppuccin.inactive.b.fg = colors.overlay0
		custom_catppuccin.inactive.c.fg = colors.overlay0

		lualine.setup({
			options = {
				icons_enabled = true,
				theme = custom_catppuccin,
				component_separators = "|",
				section_separators = { left = "", right = "" },
				disabled_filetypes = { "NvimTree", "aerial", "Avante", "AvanteSelectedFiles", "AvanteInput" },
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = {
					"branch",
					{
						"diff",
						colored = true, -- Displays a colored diff status if set to true
						symbols = {
							added = "󰝒 ",
							modified = "󰈮 ",
							removed = "󱪡 ",
						}, -- Changes the symbols used by the diff.
						source = nil, -- A function that works as a data source for diff.
					},
					"diagnostics",
				},
				lualine_c = {},
				lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_y = { "searchcount", "progress" },
				lualine_z = { "location" },
			},
			winbar = {
				lualine_b = {},
				lualine_a = {
					{
						"filename",
						path = 0,
						file_status = true,
						symbols = {
							modified = "", -- Text to show when the file is modified.
							readonly = "", -- Text to show when the file is non-modifiable or readonly.
							unnamed = "", -- Text to show for unnamed buffers.
							newfile = "", -- Text to show for newly created file before first write
						},
					},
				},
				lualine_c = {
					{
						"navic",
						color_corection = nil,
						navic_opts = {
							highlight = true,
							draw_empty = true,
						},
					},
				},
				lualine_y = {},
				lualine_x = {
					{
						"filename",
						path = 1,
						file_status = true,
						symbols = {
							modified = "", -- Text to show when the file is modified.
							readonly = "", -- Text to show when the file is non-modifiable or readonly.
							unnamed = "", -- Text to show for unnamed buffers.
							newfile = "", -- Text to show for newly created file before first write
						},
					},
				},
				lualine_z = {},
			},
			inactive_winbar = {
				lualine_a = {},
				lualine_b = {
					{
						"filename",
						path = 0,
						file_status = true,
						symbols = {
							modified = "", -- Text to show when the file is modified.
							readonly = "", -- Text to show when the file is non-modifiable or readonly.
							unnamed = "", -- Text to show for unnamed buffers.
							newfile = "", -- Text to show for newly created file before first write
						},
					},
				},
				lualine_c = {
					{
						"navic",
						color_corection = nil,
						navic_opts = {
							highlight = true,
							draw_empty = true,
						},
					},
				},
				lualine_x = {},
				lualine_y = {
					{
						"filename",
						path = 1,
						file_status = true,
						symbols = {
							modified = "", -- Text to show when the file is modified.
							readonly = "", -- Text to show when the file is non-modifiable or readonly.
							unnamed = "", -- Text to show for unnamed buffers.
							newfile = "", -- Text to show for newly created file before first write
						},
					},
				},
				lualine_z = {},
			},
			extensions = {},
		})
	end,
}
