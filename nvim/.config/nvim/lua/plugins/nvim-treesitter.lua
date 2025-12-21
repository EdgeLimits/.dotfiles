return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").setup({
      ensure_installed = {
        "astro",
        "css",
        "dockerfile",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "scss",
        "typescript",
      },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
