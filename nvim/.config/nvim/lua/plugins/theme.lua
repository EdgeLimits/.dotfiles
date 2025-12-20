-- return {
-- 	"catppuccin/nvim",
-- 	name = "catppuccin",
-- 	lazy = false,
-- 	priority = 1000,
-- 	opts = {},
-- 	config = function()
-- 		vim.cmd.colorscheme("catppuccin-mocha")
-- 	end,
-- }
-- return {
-- 	"ellisonleao/gruvbox.nvim",
-- 	lazy = false,
-- 	priority = 1000,
-- 	opts = {},
-- 	config = function()
-- 		vim.cmd.colorscheme("gruvbox")
-- 	end,
-- }
return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	opts = {},
	config = function()
		vim.cmd.colorscheme("tokyonight-night")
	end,
}
