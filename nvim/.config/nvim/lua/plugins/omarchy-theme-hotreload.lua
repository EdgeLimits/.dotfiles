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
					-- Unload the theme module
					package.loaded["plugins.theme"] = nil

					vim.schedule(function()
						local ok, theme_spec = pcall(require, "plugins.theme")
						if not ok then
							return
						end

						-- theme_spec is a single plugin spec with a custom `colorscheme` field
						local colorscheme = theme_spec.colorscheme
						if not colorscheme then
							return
						end

						local theme_plugin_name = theme_spec.name or theme_spec[1]

						-- Clear all highlight groups before applying new theme
						vim.cmd("highlight clear")
						if vim.fn.exists("syntax_on") then
							vim.cmd("syntax reset")
						end

						-- Reset background so colorscheme can set it properly
						vim.o.background = "dark"

						-- Unload theme plugin modules to force full reload
						if theme_plugin_name then
							local plugin = require("lazy.core.config").plugins[theme_plugin_name]
							if plugin then
								local plugin_dir = plugin.dir .. "/lua"
								require("lazy.core.util").walkmods(plugin_dir, function(modname)
									package.loaded[modname] = nil
									package.preload[modname] = nil
								end)
							end
						end

						-- Load and apply the colorscheme
						require("lazy.core.loader").colorscheme(colorscheme)

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
