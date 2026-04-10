return {
  "folke/tokyonight.nvim",
  colorscheme = "tokyonight-night", -- used by omarchy-theme-hotreload
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme("tokyonight-night")
  end,
}
