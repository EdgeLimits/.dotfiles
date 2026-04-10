return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local ts = require("nvim-treesitter")
    local parsers = {
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
    }

    for _, parser in ipairs(parsers) do
      ts.install(parser)
    end

    vim.api.nvim_create_autocmd("FileType", {
      pattern = parsers,
      callback = function()
        vim.treesitter.start()
      end,
    })
  end,
}
