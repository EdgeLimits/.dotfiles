return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "smiteshp/nvim-navic",
    { "catppuccin/nvim", optional = true },
    { "folke/tokyonight.nvim", optional = true },
  },
  config = function()
    local lualine = require("lualine")

    -- Read the current theme's background from the Normal highlight group.
    -- This works universally across all colorschemes.
    local function normal_bg()
      local hl = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
      return hl.bg and string.format("#%06x", hl.bg) or "NONE"
    end

    -- Try to load the lualine theme matching the active colorscheme,
    -- then set b/c and inactive sections to the theme's background. Falls back to "auto".
    local function build_theme()
      local ok, t = pcall(require, "lualine.themes." .. (vim.g.colors_name or ""))
      if not ok then
        return "auto"
      end

      local bg = normal_bg()

      for _, mode in ipairs({ "normal", "insert", "visual", "replace", "command", "inactive" }) do
        if t[mode] then
          for _, section in ipairs({ "a", "b", "c" }) do
            if t[mode][section] and (mode == "inactive" or section ~= "a") then
              t[mode][section].bg = bg
            end
          end
        end
      end

      return t
    end

    local filename_symbols = {
      modified = "",
      readonly = "",
      unnamed = "",
      newfile = "",
    }

    local function setup()
      lualine.setup({
        options = {
          icons_enabled = true,
          theme = build_theme(),
          component_separators = "|",
          section_separators = { left = "", right = "" },
          disabled_filetypes = { "NvimTree", "aerial", "Avante", "AvanteSelectedFiles", "AvanteInput" },
        },
        sections = {
          lualine_a = { { "mode", separator = { right = "" } } },
          lualine_b = {
            "branch",
            {
              "diff",
              colored = true,
              symbols = {
                added = "󰝒 ",
                modified = "󰈮 ",
                removed = "󱪡 ",
              },
            },
            "diagnostics",
          },
          lualine_c = {},
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "searchcount", "progress" },
          lualine_z = { { "location", separator = { left = "" } } },
        },
        winbar = {
          lualine_a = {
            { "filename", path = 0, file_status = true, symbols = filename_symbols },
          },
          lualine_c = {
            {
              "navic",
              color_correction = nil,
              navic_opts = { highlight = true, draw_empty = true },
            },
          },
          lualine_x = {
            { "filename", path = 1, file_status = true, symbols = filename_symbols },
          },
        },
        inactive_winbar = {
          lualine_b = {
            { "filename", path = 0, file_status = true, symbols = filename_symbols },
          },
          lualine_c = {
            {
              "navic",
              color_correction = nil,
              navic_opts = { highlight = true, draw_empty = true },
            },
          },
          lualine_y = {
            { "filename", path = 1, file_status = true, symbols = filename_symbols },
          },
        },
        extensions = {},
      })
    end

    setup()

    -- Re-apply when theme changes (triggered by omarchy-theme-hotreload)
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = setup,
    })
  end,
}
