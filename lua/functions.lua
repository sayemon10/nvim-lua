-- ~/.config/nvim/lua/functions.lua

-- Custom Lua Functions
-- Equivalent to 'function!' blocks in .vimrc

-- Define the module table M
local M = {}

-- Global function to toggle GitHub Copilot
-- This function checks Copilot's status and enables/disables it.
function _G.ToggleCopilot()
  -- Check if Copilot is enabled using vim.fn (Vimscript function call from Lua)
  if vim.fn['copilot#Enabled']() then
    vim.cmd('Copilot disable')
  else
    vim.cmd('Copilot enable')
  end
  -- Display Copilot status (using Copilot's own status command)
  vim.cmd('Copilot status')
end

-- Local function for LSP buffer enabled callback
-- This function is called when an LSP server is attached to a buffer.
-- It sets buffer-local options and keymaps for LSP features.
function M.on_lsp_buffer_enabled()
  -- Set buffer-local omnicompletion to LSP's complete function
  vim.opt_local.omnifunc = 'lsp#complete'
  -- Always show the sign column for diagnostics
  vim.opt_local.signcolumn = 'yes'

  -- Buffer-local LSP keymaps
  vim.keymap.set('n', 'gi', '<plug>(lsp-definition)', { buffer = true, desc = 'LSP: Go to Definition' })
  vim.keymap.set('n', 'gd', '<plug>(lsp-declaration)', { buffer = true, desc = 'LSP: Go to Declaration' })
  vim.keymap.set('n', 'gr', '<plug>(lsp-references)', { buffer = true, desc = 'LSP: Find References' })
  vim.keymap.set('n', 'gl', '<plug>(lsp-document-diagnostics)', { buffer = true, desc = 'LSP: Show Line Diagnostics' })
  vim.keymap.set('n', '<f2>', '<plug>(lsp-rename)', { buffer = true, desc = 'LSP: Rename Symbol' })
  vim.keymap.set('n', '<f3>', '<plug>(lsp-hover)', { buffer = true, desc = 'LSP: Show Hover Info' })
end

-- Return the module table (important for `require` to work)
return M
