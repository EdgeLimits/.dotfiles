return {
	"nvim-tree/nvim-tree.lua",
	dependencies = { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
	config = function()
		local tree = require("nvim-tree")
		tree.setup({ -- Configuration options go here
			view = {
				side = "right", -- Place the file explorer on the right side
				width = 30, -- Adjust the width as needed
			},
			update_focused_file = {
				enable = true, -- Update the focused file
				update_cwd = true, -- Update the current working directory
			},
			-- Key mapping for toggling nvim-tree with <Leader>e
			vim.api.nvim_set_keymap("n", "<Leader>fe", ":NvimTreeToggle<CR>", { noremap = true, silent = true }),
		})
	end,
}
