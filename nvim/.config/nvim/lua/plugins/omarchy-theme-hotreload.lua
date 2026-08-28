-- Applies the new colorscheme in every running Neovim when the Omarchy theme
-- changes, without a restart.
--
-- Chain: `omarchy theme set X` regenerates
-- ~/.local/state/omarchy/current/theme/neovim.lua, then runs the
-- theme-set.d/nvim hook, which touches lua/plugins/theme.lua. lazy.nvim's
-- change_detection notices and fires User LazyReload, which lands here.

return {
	{
		name = "theme-hotreload",
		dir = vim.fn.stdpath("config"),
		lazy = false,
		priority = 1000,
		config = function()
			local transparency_file = vim.fn.stdpath("config") .. "/plugin/after/transparency.lua"

			vim.api.nvim_create_autocmd("User", {
				pattern = "LazyReload",
				callback = function()
					-- Drop both caches so the generated spec is re-read from disk.
					package.loaded["plugins.theme"] = nil
					package.loaded["omarchy_theme"] = nil

					vim.schedule(function()
						local ok, omarchy = pcall(require, "omarchy_theme")
						if not ok then
							return
						end

						local _, colorscheme, theme_plugin_name = omarchy.read()
						if not colorscheme then
							return
						end

						-- Clear all highlight groups before applying new theme
						vim.cmd("highlight clear")
						if vim.fn.exists("syntax_on") then
							vim.cmd("syntax reset")
						end

						-- Reset background so colorscheme can set it properly
						vim.o.background = "dark"

						local plugin = theme_plugin_name and require("lazy.core.config").plugins[theme_plugin_name]

						-- Unload theme plugin modules to force full reload
						if plugin then
							require("lazy.core.util").walkmods(plugin.dir .. "/lua", function(modname)
								package.loaded[modname] = nil
								package.preload[modname] = nil
							end)
						end

						-- If the plugin is already loaded -- which happens whenever two
						-- themes share one plugin, e.g. every theme that falls back to
						-- aether -- lazy will not re-run setup() on a spec reload and
						-- keeps the previous theme's resolved opts cached. Force a full
						-- reload so setup() reapplies with the new opts.
						if plugin and plugin._ and plugin._.loaded then
							require("lazy.core.loader").reload(plugin)
						else
							require("lazy.core.loader").colorscheme(colorscheme)
						end

						vim.defer_fn(function()
							pcall(vim.cmd.colorscheme, colorscheme)
							vim.cmd("redraw!")

							if vim.fn.filereadable(transparency_file) == 1 then
								vim.defer_fn(function()
									vim.cmd.source(transparency_file)
									vim.api.nvim_exec_autocmds("ColorScheme", { modeline = false })
									vim.api.nvim_exec_autocmds("VimEnter", { modeline = false })
									vim.cmd("redraw!")
								end, 5)
							end
						end, 5)
					end)
				end,
			})
		end,
	},
}
