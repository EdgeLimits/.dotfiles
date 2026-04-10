return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  tag = "v0.9.3",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "bash",
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
        "svelte",
      },
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
