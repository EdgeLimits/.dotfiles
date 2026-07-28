return {
  "rebelot/kanagawa.nvim",
  colorscheme = "kanagawa", -- used by omarchy-theme-hotreload
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme("kanagawa")
  end,
}
