return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>lf",
      function()
        require("conform").format({ async = true })
      end,
      mode = "",
      desc = "Format file or range (in visual mode)",
    },
  },
  opts = {
    -- Define your formatters
    formatters_by_ft = {
      lua = { "stylua" },
      javascript = { "prettierd", "prettier", stop_after_first = true },
      typescript = { "prettierd", "prettier", stop_after_first = true },
      javascriptreact = { "prettierd", "prettier", stop_after_first = true },
      typescriptreact = { "prettierd", "prettier", stop_after_first = true },
      json = { "prettierd", "prettier", stop_after_first = true },
      html = { "htmlbeautifier" },
      python = { "black" },
      css = { "prettierd", "prettier", stop_after_first = true },
      scss = { "prettierd", "prettier", stop_after_first = true },
      svelte = { "prettierd", "prettier", stop_after_first = true },
      astro = { "prettierd", "prettier", stop_after_first = true },
    },
    -- Set default options
    default_format_opts = {
      lsp_format = "never",
    },
    -- Set up format-on-save
    format_on_save = {
      timeout_ms = 5000,
    },
  },
}
