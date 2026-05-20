-- ~/.config/nvim/init.lua

-- Author: sayemon10
-- URL: https://www.sayemon10.com

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Set mapleader and maplocalleader before loading lazy.nvim
vim.g.mapleader = "-"
vim.g.maplocalleader = "-"

-- Load configuration modules
require('options')   -- General Neovim options
require('keymaps')   -- Keybindings
require('autocmds')  -- Autocommands
require('functions') -- Custom Lua functions

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        { import = "plugins" }, -- Import plugins from lua/plugins/
    },
    install = { colorscheme = { "gruvbox" } },
    checker = { enabled = true },
})

-- Enable syntax highlighting
vim.cmd('syntax on enable')

-- Ensure filetype detection, plugins, and indenting are on
vim.cmd('filetype plugin indent on')

-- Load matchit plugin
vim.cmd('packadd! matchit')
