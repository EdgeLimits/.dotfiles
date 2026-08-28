-- Active colorscheme, derived from Omarchy's generated theme spec.
--
-- This file is static: the theme it resolves to changes because
-- ~/.local/state/omarchy/current/theme/neovim.lua changes. Nothing rewrites
-- this file, so it no longer shows up dirty in git after a theme switch.
--
-- The theme-set.d/nvim hook touches this file after a switch, which is what
-- lazy.nvim's change_detection notices to fire the hot reload.

local omarchy = require("omarchy_theme")
local specs, colorscheme = omarchy.read()

if #specs == 0 or not colorscheme then
  -- No Omarchy theme state (fresh install, or Omarchy not present).
  return {}
end

-- The generated spec marks the plugin lazy; we want it applied at startup.
specs[1].lazy = false
specs[1].priority = 1000

local previous_config = specs[1].config
specs[1].config = function(plugin, opts)
  if previous_config then
    previous_config(plugin, opts)
  end
  pcall(vim.cmd.colorscheme, colorscheme)
end

-- Read by omarchy-theme-hotreload.lua.
specs[1].colorscheme = colorscheme

return specs
