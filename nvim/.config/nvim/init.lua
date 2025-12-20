-- Map the <Leader> key to <Space>.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
        local lazyrepo = "https://github.com/folke/lazy.nvim.git"
        vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Disable some in-built features which are unnecessary (and probably affects performance?)
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

-- INFO: Enable an experimental fast module loader. See the PR for more information:
vim.loader.enable()
vim.o.termguicolors = true

local config = {
        { import = "plugins" },
}

local opts = {
        checker = {
                enable = true,
                notify = false,
        },
        change_detection = {
                notify = false,
        },
}

local modules = {
        "options",
}

-- vim.cmd.colorscheme("tokyonight-night")

-- local vimrc = vim.fn.stdpath("config") .. "/vimrc.vim"
-- vim.cmd.source(vimrc)

require("lazy").setup(config, opts)

for _, module in ipairs(modules) do
        local ok, error = pcall(require, module)
        if not ok then
                print("Error loading module: " .. error)
        end
end
