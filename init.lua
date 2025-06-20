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
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = "-"
vim.g.maplocalleader = "-"

-- Require and load your configuration modules
-- These files contain your settings, keymaps, plugins, etc.
require('options')    -- General Neovim options
require('keymaps')    -- Keybindings
require('autocmds')   -- Autocommands
require('functions')  -- Custom Lua functions
require('plugins')    -- plugins

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins from lua/plugins.lua
    { import = "plugins" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  -- This is a fallback colorscheme for the *installation* phase, not your primary one.
  install = { colorscheme = { "gruvbox" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

-- Enable syntax highlighting (usually handled by filetype plugin, but explicit is fine)
vim.cmd('syntax on enable')

-- Ensure filetype detection, plugins, and indenting are on
vim.cmd('filetype plugin indent on')

-- For matchit, which is a built-in runtime plugin
vim.cmd('packadd! matchit')

