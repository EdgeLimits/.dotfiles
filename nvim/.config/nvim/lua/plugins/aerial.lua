return {
	"stevearc/aerial.nvim",
	opts = {},
	-- Optional dependencies
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local aerial = require("aerial")

		aerial.setup({
			highlight_on_hover = true,
			layout = {
				min_width = 30,
				default_direction = "right",
				win_opts = {
					winhighlight = "Normal:AerialNormal",
				},
			},

			vim.api.nvim_set_keymap("n", "<Leader>fa", ":AerialToggle<CR>", { noremap = true, silent = true }),
		})
	end,
}
