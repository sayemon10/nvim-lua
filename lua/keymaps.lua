-- ~/.config/nvim/lua/keymaps.lua

-- Key Mappings
-- Equivalent to 'map', 'nnoremap', 'inoremap', 'vnoremap', 'imap', 'tmap' in .vimrc

-- General mappings
-- <Esc><Esc> to save (map applies to all modes)
vim.keymap.set({'n', 'i', 'v', 'c', 't'}, '<Esc><Esc>', ':w<CR>', { desc = 'Save file' })

-- Disable arrow keys in normal mode (common for touch typists)
vim.keymap.set('n', '<Down>', '<Nop>', { desc = 'Disable Down arrow' })
vim.keymap.set('n', '<Up>', '<Nop>', { desc = 'Disable Up arrow' })
vim.keymap.set('n', '<Left>', '<Nop>', { desc = 'Disable Left arrow' })
vim.keymap.set('n', '<Right>', '<Nop>', { desc = 'Disable Right arrow' })

-- Leader key mappings
vim.keymap.set('n', '<leader>f', ':e <CR>', { desc = 'Edit new file' })
vim.keymap.set('n', '<leader>s', ':split<CR>', { desc = 'Split window horizontally' })
vim.keymap.set('n', '<leader>v', ':vsplit<CR>', { desc = 'Split window vertically' })
vim.keymap.set('n', '<leader>w', ':%s/\\s\\+$//e<CR>', { desc = 'Remove trailing whitespace' })

-- Insert mode 'o' and 'O' (exit insert mode after inserting new line)

vim.keymap.set('n', 'O', 'O<Esc>', { desc = 'Insert line above and exit insert mode' })
vim.keymap.set('n', 'o', 'o<Esc>', { desc = 'Insert line below and exit insert mode' })

-- Move lines up/down (Alt-j/k)
vim.keymap.set('n', '<A-j>', ':m .+1<CR>==', { desc = 'Move line down' })
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==', { desc = 'Move line up' })
vim.keymap.set('i', '<A-j>', '<Esc>:m .+1<CR>==gi', { desc = 'Move line down (Insert mode)' })
vim.keymap.set('i', '<A-k>', '<Esc>:m .-2<CR>==gi', { desc = 'Move line up (Insert mode)' })
vim.keymap.set('v', '<A-j>', ':m \'>+1<CR>gv=gv', { desc = 'Move selected lines down' })
vim.keymap.set('v', '<A-k>', ':m \'<-2<CR>gv=gv', { desc = 'Move selected lines up' })

-- Buffer navigation and management
vim.keymap.set({'n', 'i'}, '<F5>', '<Esc>:bp<CR>', { desc = 'Previous buffer' })
vim.keymap.set('t', '<F5>', '<C-W>:bp<CR>', { desc = 'Previous buffer (Terminal)' })
vim.keymap.set({'n', 'i'}, '<F6>', '<Esc>:bn<CR>', { desc = 'Next buffer' })
vim.keymap.set('t', '<F6>', '<C-W>:bn<CR>', { desc = 'Next buffer (Terminal)' })
vim.keymap.set({'n', 'i'}, '<F7>', '<Esc>:bd<CR>', { desc = 'Delete buffer' })
vim.keymap.set({'n', 'i'}, '<F8>', '<Esc>:ls<CR>', { desc = 'List buffers' })
vim.keymap.set('t', '<F8>', '<C-W>:ls<CR>', { desc = 'List buffers (Terminal)' })

-- Copy current file path to clipboard
vim.keymap.set({'n', 'i'}, '<F9>', '<Esc>:let @+ = fnamemodify(@%, ":p")<CR>', { desc = 'Copy file path' })

-- Quickfix list navigation
vim.keymap.set({'n', 'i'}, '<F10>', '<Esc>:cp<CR>', { desc = 'Previous quickfix result' })
vim.keymap.set({'n', 'i'}, '<F11>', '<Esc>:cn<CR>', { desc = 'Next quickfix result' })

-- Yank to system clipboard
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

vim.api.nvim_create_autocmd(
    "LspAttach",
    { --  Use LspAttach autocommand to only map the following keys after the language server attaches to the current buffer
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
            vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc" -- Enable completion triggered by <c-x><c-o>

            -- Buffer local mappings.
            -- See `:help vim.lsp.*` for documentation on any of the below functions
            local opts = { buffer = ev.buf }
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
            vim.keymap.set("n", "<leader><space>", vim.lsp.buf.hover, opts)
            vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
            vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
            vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
            vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

            vim.keymap.set("n", "<leader>f", function()
                vim.lsp.buf.format({ async = true })
            end, opts)

            -- Open the diagnostic under the cursor in a float window
            vim.keymap.set("n", "<leader>d", function()
                vim.diagnostic.open_float({
                    border = "rounded",
                })
            end, opts)
        end,
    }
)

-- GitHub Copilot mappings
vim.keymap.set('n', '<F1>', ':Copilot panel<CR>', { desc = 'Show Copilot panel' })
vim.keymap.set('i', '<F12>', '<Esc>:lua ToggleCopilot()<CR>a', { desc = 'Toggle Copilot (Insert mode)' })
vim.keymap.set('n', '<F12>', ':lua ToggleCopilot()<CR>', { desc = 'Toggle Copilot (Normal mode)' })
vim.keymap.set('i', '<C-M-[>', '<Plug>(copilot-previous)', { desc = 'Copilot previous suggestion' })
vim.keymap.set('i', '<C-M-]>', '<Plug>(copilot-next)', { desc = 'Copilot next suggestion' })
