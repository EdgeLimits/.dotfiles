# Neovim Theme Autoreload

Switching omarchy themes automatically updates the Neovim colorscheme in all running instances.

## How it works

1. `omarchy-theme-set "Theme Name"` runs the hook at `~/.config/omarchy/hooks/theme-set`
2. The hook reads the omarchy theme's `neovim.lua` and writes a converted spec to `nvim/.config/nvim/lua/plugins/theme.lua`
3. Lazy.nvim detects the file change (`change_detection` is enabled) and fires `User LazyReload`
4. `omarchy-theme-hotreload.lua` catches the event, unloads the old theme modules, and applies the new colorscheme

## Files

| File | Purpose |
|------|---------|
| `~/.config/omarchy/hooks/theme-set` | Hook that rewrites `theme.lua` on every theme switch |
| `nvim/.config/nvim/lua/plugins/theme.lua` | Active colorscheme plugin spec — rewritten by the hook |
| `nvim/.config/nvim/lua/plugins/omarchy-theme-hotreload.lua` | Listens for `LazyReload` and applies the colorscheme |

## theme.lua format

A single lazy.nvim plugin spec with a custom `colorscheme` field used by the hotreload:

```lua
return {
  "folke/tokyonight.nvim",
  colorscheme = "tokyonight-night", -- read by omarchy-theme-hotreload
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme("tokyonight-night")
  end,
}
```

The `LazyVim/LazyVim` format from omarchy's stock `neovim.lua` files is intentionally avoided — it would cause lazy.nvim to install the entire LazyVim framework.

## Lualine integration

Lualine rebuilds its theme on every `ColorScheme` event using a generic `build_theme()` function:

- Loads `lualine.themes.<current_colorscheme>` dynamically — no hardcoded theme names
- Uses `vim.api.nvim_get_hl(0, { name = "Normal", link = false }).bg` to read the theme's background color and apply it to the non-highlighted b/c sections
- Rounded separators (``) only on `lualine_a` and `lualine_z` (the highlighted pill sections)
