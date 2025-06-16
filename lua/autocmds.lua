-- ~/.config/nvim/lua/autocmds.lua

-- Autocommands
-- Equivalent to 'autocmd' and 'augroup' in .vimrc

-- HTML filetype specific omnifunc
-- This sets the omnicompletion function for HTML files.
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'html',
  callback = function()
    vim.opt_local.omnifunc = 'htmlcomplete#CompleteTags'
  end,
  desc = 'Set omnifunc for HTML files',
})

-- LSP installation autogroup
-- This group defines autocommands related to LSP buffer enablement.
-- The 'User lsp_buffer_enabled' event is triggered by vim-lsp when a buffer has LSP enabled.
vim.api.nvim_create_augroup('lsp_install', { clear = true }) -- clear = true ensures the group is reset
vim.api.nvim_create_autocmd('User', {
  group = 'lsp_install',
  pattern = 'lsp_buffer_enabled',
  callback = function()
    require('functions').on_lsp_buffer_enabled() -- Call the Lua function
  end,
  desc = 'Trigger on_lsp_buffer_enabled for LSP',
})

