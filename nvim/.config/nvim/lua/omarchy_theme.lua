-- Reads the Neovim theme spec that Omarchy generates for the current theme.
--
-- Omarchy 4 writes ~/.local/state/omarchy/current/theme/neovim.lua on every
-- `omarchy theme set`, in a uniform shape: the real colorscheme plugin, plus a
-- { "LazyVim/LazyVim", opts = { colorscheme = "..." } } entry carrying the name
-- to apply. This replaces the hand-maintained slug -> plugin -> colorscheme
-- tables the pre-Quattro theme-set hook used to keep in sync by hand.
--
-- We are not a LazyVim config, so the LazyVim entry must be filtered out before
-- the specs reach lazy.nvim -- importing it verbatim would pull in the whole
-- framework.

local M = {}

M.spec_path = vim.fn.expand("~/.local/state/omarchy/current/theme/neovim.lua")

-- Omarchy emits a few colorscheme names that only exist as LazyVim aliases, not
-- as real `:colorscheme` targets. Map those to the actual name.
local ALIASES = {
  ["catppuccin-nvim"] = "catppuccin",
}

--- @return table specs   plugin specs to hand to lazy.nvim (LazyVim removed)
--- @return string|nil colorscheme  the colorscheme to apply
--- @return string|nil plugin_name  lazy's name for the theme plugin
function M.read()
  if vim.fn.filereadable(M.spec_path) ~= 1 then
    return {}, nil, nil
  end

  local ok, generated = pcall(dofile, M.spec_path)
  if not ok or type(generated) ~= "table" then
    return {}, nil, nil
  end

  local specs, colorscheme, plugin_name = {}, nil, nil

  for _, spec in ipairs(generated) do
    if spec[1] == "LazyVim/LazyVim" then
      if spec.opts and spec.opts.colorscheme then
        colorscheme = spec.opts.colorscheme
      end
    else
      if spec[1] and not plugin_name then
        plugin_name = spec.name or spec[1]
      end
      table.insert(specs, spec)
    end
  end

  colorscheme = colorscheme and (ALIASES[colorscheme] or colorscheme) or nil

  return specs, colorscheme, plugin_name
end

return M
