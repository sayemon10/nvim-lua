-- ~/.config/nvim/lua/functions.lua

local M = {}

-- Toggle Copilot suggestions for current buffer
function _G.ToggleCopilot()
    local suggestion = require('copilot.suggestion')
    suggestion.toggle_auto_trigger()
    local status = suggestion.is_visible() and "enabled" or "disabled"
    vim.notify("Copilot auto-trigger " .. status, vim.log.levels.INFO)
end

-- LSP buffer setup (your existing code, but FIXED keymaps)
function M.on_lsp_buffer_enabled()
    vim.opt_local.omnifunc = 'v:lua.vim.lsp.omnifunc'
    vim.opt_local.signcolumn = 'yes'
end

return M
