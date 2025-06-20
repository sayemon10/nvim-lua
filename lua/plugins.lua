-- ~/.config/nvim/lua/plugins.lua

require('lazy').setup({
    -- Existing plugins...
    { 'github/copilot.vim' },
    { 'williamboman/mason.nvim', lazy = false, config = function() require('mason').setup() end },
    { 'williamboman/mason-lspconfig.nvim', lazy = false, dependencies = { 'williamboman/mason.nvim', 'neovim/nvim-lspconfig' }, opts = { auto_install = true, ensure_installed = { 'lua_ls', 'tailwindcss' } } }, -- Add tailwindcss here
    { 'neovim/nvim-lspconfig', dependencies = { 'williamboman/mason-lspconfig.nvim' }, 
    config = function()
        require('lsp-config') -- Load the separate LSP config file
    end,
    opts = {
        inlay_hints = { enabled = false },
    },}, -- Config moved to separate file
    { 'nvim-lualine/lualine.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' }, config = function()require('lualine').setup({
                options = {
                    icons_enabled = true,
                    theme = 'gruvbox',
                },
                sections = {
                    lualine_a = { 'mode' },
                    lualine_b = {
                        {
                            function()
                                return 'BN: ' .. vim.api.nvim_buf_get_number(0)
                            end,
                            color = { fg = '#bb992a' },
                        },
                        'branch',
                        'diff',
                    },
                    lualine_c = { 'filename' },
                    lualine_x = { 'diagnostics', 'encoding', 'fileformat', 'filetype' },
                    lualine_y = {
                        {
                            function()
                                return os.date('%c')
                            end,
                            color = { fg = '#99bb2a' },
                        },
                        'progress',
                    },
                    lualine_z = { 'location' },
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { 'filename' },
                    lualine_x = { 'location' },
                    lualine_y = {},
                    lualine_z = {},
                },
                tabline = {},
                extensions = {},
            })
        end,},
    { 'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        dependencies = { 'nvim-lua/plenary.nvim', { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' } },
        config = function()
            vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files)
            vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep)
            vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers)
            vim.keymap.set('n', '<leader>fc', require('telescope.builtin').commands)
        end,},
    { 'mattn/emmet-vim' },
    { 'morhetz/gruvbox', config = function() vim.cmd('colorscheme gruvbox') end },
    { 'vhyrro/luarocks.nvim', priority = 1000, config = true },

    -- New plugins for autocompletion
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp', -- LSP source
            'hrsh7th/cmp-buffer', -- Buffer source
            'hrsh7th/cmp-path', -- Path source
            'L3MON4D3/LuaSnip', -- Snippet engine
            'saadparwaiz1/cmp_luasnip', -- Snippet completion
            'roobert/tailwindcss-colorizer-cmp.nvim', -- Optional: Color previews for Tailwind
        },
        config = function()
            local cmp = require('cmp')
            cmp.setup({
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-t>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                    ['<Tab>'] = cmp.mapping.select_next_item(),
                    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp', max_item_count = 20, keyword_length = 3 }, -- Limit suggestions for performance
                    { name = 'luasnip' },
                    { name = 'buffer' },
                    { name = 'path' },
                }),
                formatting = {
                    format = require('tailwindcss-colorizer-cmp').formatter, -- Enable color previews
                },
            })
        end,
    },
}, {
    checker = {
        enabled = true,
        frequency = 60 * 60 * 24 * 7,
    },
})

vim.cmd('packadd! matchit')
