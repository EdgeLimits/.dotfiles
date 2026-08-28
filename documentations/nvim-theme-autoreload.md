# Neovim Theme Autoreload

Switching Omarchy themes updates the Neovim colorscheme in all running instances.

## How it works

Omarchy 4 generates the Neovim theme spec itself, so this no longer maintains a
mapping of theme slugs to plugins by hand.

1. `omarchy theme set "Tokyo Night"` renders
   `~/.local/state/omarchy/current/theme/neovim.lua` from the theme's own
   `neovim.lua`, or from `$OMARCHY_PATH/default/themed/neovim.lua.tpl` (aether)
   for themes that ship none.
2. It then runs the hook `~/.config/omarchy/hooks/theme-set.d/nvim`, which
   `touch`es `lua/plugins/theme.lua`. The file's *content* never changes -- only
   its mtime.
3. lazy.nvim's `change_detection` polls its imported spec modules every 2s
   (size + mtime) and fires `User LazyReload`.
4. `lua/plugins/omarchy-theme-hotreload.lua` catches the event, unloads the old
   theme plugin's modules, and applies the new colorscheme.

## The generated spec, and the two things we fix up

Every generated `neovim.lua` has the same shape: the real colorscheme plugin,
plus a `LazyVim/LazyVim` entry whose `opts.colorscheme` names what to apply.

```lua
return {
  { "folke/tokyonight.nvim", priority = 1000 },
  { "LazyVim/LazyVim", opts = { colorscheme = "tokyonight-night" } },
}
```

`lua/omarchy_theme.lua` reads that file and handles both catches:

1. **The `LazyVim/LazyVim` entry must be filtered out.** This is not a LazyVim
   config; passing that spec through to lazy.nvim would install the entire
   framework. The helper drops it and keeps only `opts.colorscheme`.
2. **Some colorscheme names are LazyVim aliases, not real ones.** Catppuccin
   emits `catppuccin-nvim`, which is not a valid `:colorscheme` target. The
   helper has a small alias table for these; it currently needs exactly one
   entry.

## Files

| File | Purpose |
|------|---------|
| `nvim/.config/nvim/lua/omarchy_theme.lua` | Reads Omarchy's generated spec; filters LazyVim, resolves aliases |
| `nvim/.config/nvim/lua/plugins/theme.lua` | Static wrapper returning the current theme's spec |
| `nvim/.config/nvim/lua/plugins/all-themes.lua` | Every theme plugin, pre-registered `lazy = true` |
| `nvim/.config/nvim/lua/plugins/omarchy-theme-hotreload.lua` | Applies the new colorscheme on `LazyReload` |
| `nvim/.config/omarchy/hooks/theme-set.d/nvim` | Touches `theme.lua` after a theme change |

`all-themes.lua` is the union of the plugins every stock theme asks for, so a
switch never has to clone at runtime. Regenerate it with:

```bash
grep -ho '"[^"]*/[^"]*"' /usr/share/omarchy/themes/*/neovim.lua | sort -u
```

Two entries there are load-bearing beyond the plain URL: aether needs
`branch = "v3"` and `name = "aether"` to match the generated spec (lazy merges
by URL and renames by `name`, so a mismatch builds into the wrong directory and
costs a clone plus a wrong theme until restart), and catppuccin/rose-pine need
their `name` set the same way Omarchy sets it.

## Lualine integration

Lualine rebuilds its theme on every `ColorScheme` event via a generic
`build_theme()`:

- Loads `lualine.themes.<current_colorscheme>` dynamically -- no hardcoded names
- Reads the theme's background with
  `vim.api.nvim_get_hl(0, { name = "Normal", link = false }).bg` and applies it
  to the non-highlighted b/c sections
- Rounded separators only on `lualine_a` and `lualine_z`

This needed no changes for Omarchy 4 -- it derives everything from
`vim.g.colors_name`.

## What this replaced

Before Omarchy 4 the hook carried three hand-maintained bash tables
(`THEME_PLUGIN`, `THEME_PLUGIN_NAME`, `THEME_COLORSCHEME`) covering 14 themes,
and *rewrote* `theme.lua` on every switch -- which also left this repo dirty
after every theme change. Omarchy 3's per-theme `neovim.lua` files were too
inconsistent to parse; Omarchy 4 normalized them, so the tables are gone.

Themes with no mapping used to be skipped with a notification. Every theme is
covered now: 16 stock themes name a real plugin, and the remaining 6 fall back
to aether.
