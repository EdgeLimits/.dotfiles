-- Every colorscheme plugin any Omarchy theme can ask for, pre-registered as
-- lazy so switching themes never has to clone at runtime.
--
-- This is the union of the plugins named by all stock Omarchy 4 themes'
-- neovim.lua files, not a hand-picked subset -- the pre-Quattro list was
-- curated by hand and drifted from what Omarchy actually asks for (it had
-- shaunsingh/nord.nvim and sainnhe/everforest, where Omarchy asks for
-- EdenEast/nightfox.nvim and neanias/everforest-nvim).
--
-- Regenerate with:
--   grep -ho '"[^"]*/[^"]*"' /usr/share/omarchy/themes/*/neovim.lua | sort -u

return {
	-- aether is the fallback for every theme that ships no neovim.lua of its
	-- own (ethereal, last-horizon, lupine, miasma, ristretto, vantablack,
	-- white) via default/themed/neovim.lua.tpl.
	--
	-- name and branch must match Omarchy's generated spec exactly. lazy merges
	-- specs by url and an explicit name renames the merged plugin, so a bare
	-- "bjarneo/aether.nvim" here would build into lazy/aether.nvim while the
	-- generated spec renames it to lazy/aether -- a directory that does not
	-- exist, costing a clone on first launch and falling back to the wrong
	-- theme until restart.
	{ "bjarneo/aether.nvim", branch = "v3", name = "aether", lazy = true },

	{ "catppuccin/nvim", name = "catppuccin", lazy = true },
	{ "rose-pine/neovim", name = "rose-pine", lazy = true },

	{ "EdenEast/nightfox.nvim", lazy = true },
	{ "ellisonleao/gruvbox.nvim", lazy = true },
	{ "ficcdaf/ashen.nvim", lazy = true },
	{ "folke/tokyonight.nvim", lazy = true },
	{ "bjarneo/hackerman.nvim", lazy = true },
	{ "kepano/flexoki-neovim", lazy = true },
	{ "neanias/everforest-nvim", lazy = true },
	{ "OldJobobo/retro-82.nvim", lazy = true },
	{ "omacom-io/lumon.nvim", lazy = true },
	{ "rebelot/kanagawa.nvim", lazy = true },
	{ "ribru17/bamboo.nvim", lazy = true },
	{ "tahayvr/matteblack.nvim", lazy = true },
}
