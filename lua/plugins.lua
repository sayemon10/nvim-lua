-- ~/.config/nvim/lua/plugins.lua

return {
    {
        'github/copilot.vim',
        config = function()
            vim.g.copilot_no_tab_map = false -- Disable Copilot's default Tab mapping
        end,
    },
    {
        'williamboman/mason.nvim',
        lazy = false,
        config = function()
            require('mason').setup()
        end,
    },
    {
        'williamboman/mason-lspconfig.nvim',
        lazy = false,
        dependencies = { 'williamboman/mason.nvim' },
        config = function()
            require('mason-lspconfig').setup({
                ensure_installed = { 'lua_ls', 'tailwindcss' },
                automatic_installation = true,
            })
        end,
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = { 'williamboman/mason-lspconfig.nvim' },
        config = function()
            require('lsp-config') -- Load the separate LSP config file
        end,
    },
    {
        'artemave/workspace-diagnostics.nvim',
        lazy = false,
        dependencies = { 'neovim/nvim-lspconfig' },
        config = function()
            require('workspace-diagnostics').setup({
                auto_open = true,
                auto_close = true,
                auto_refresh = true,
                diagnostics = {
                    enable = true,
                    debounce = 1000,
                },
            })
        end,
    },
    {
        'alvan/vim-closetag', -- Or the specific Neovim version if available
        config = function()
            -- Optional: Configure settings
            vim.g.closetag_filenames = '*.html,*.xhtml,*.jsx'
            vim.g.closetag_filetypes = 'html,xhtml,jsx'
        end
    },
    {
        'j-hui/fidget.nvim',
        config = function()
            require('fidget').setup({})
        end,
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('lualine').setup({
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
                    lualine_x = {
                        {
                            'diagnostics',
                            sources = { "nvim_workspace_diagnostic" }
                        },
                        'encoding',
                        'fileformat',
                        'filetype'
                    },
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
        end,
    },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-ui-select.nvim',
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        },
        config = function()
            require('telescope').setup()
            require('telescope').load_extension('ui-select')
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', builtin.find_files)
            vim.keymap.set('n', '<leader>fg', builtin.live_grep)
            vim.keymap.set('n', '<leader>fb', builtin.buffers)
            vim.keymap.set('n', '<leader>fc', builtin.commands)
        end,
    },
    { 'mattn/emmet-vim' },
    {
        'morhetz/gruvbox',
        config = function()
            vim.cmd('colorscheme gruvbox')
        end,
    },
    {
        'projekt0n/github-nvim-theme',
        name = 'github-theme',
        lazy = false,    -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            require('github-theme').setup({
                -- ...
            })

            vim.cmd('colorscheme github_dark')
        end,
    },
    {
        'vhyrro/luarocks.nvim',
        priority = 1000,
        config = true,
    },
    {
        "zbirenbaum/copilot-cmp",
        config = function()
            require("copilot_cmp").setup()
        end
    },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            'roobert/tailwindcss-colorizer-cmp.nvim',
            'zbirenbaum/copilot-cmp',
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
                    -- Copilot Source
                    { name = "copilot",  group_index = 2 },
                    -- Other Sources
                    { name = "nvim_lsp", group_index = 2, max_item_count = 20, keyword_length = 3 },
                    { name = "path",     group_index = 2 },
                    { name = "luasnip",  group_index = 2 },
                    { name = 'buffer' },
                }),
                formatting = {
                    format = require('tailwindcss-colorizer-cmp').formatter,
                },
            })
        end,
    },
    --    {
    --        'saghen/blink.cmp',
    --        dependencies = { 'rafamadriz/friendly-snippets' },
    --        version = '1.*',
    --        config = function()
    --            require('blink.cmp').setup({
    --                keymap = {
    --                    preset = 'default',
    --                    ['<CR>'] = { 'accept', 'fallback' },
    --                    ['<C><leader>'] = { 'show' },
    --                },
    --                appearance = {
    --                    nerd_font_variant = 'mono',
    --                },
    --                completion = {
    --                    documentation = { auto_show = true },
    --                },
    --                sources = {
    --                    default = { 'lsp', 'path', 'snippets', 'buffer' },
    --                },
    --                fuzzy = { implementation = 'prefer_rust_with_warning' },
    --            })
    --        end,
    --    },
    {
        'stevearc/conform.nvim',
        config = function()
            require('conform').setup({
                formatters_by_ft = {
                    lua = { 'stylua' },
                    javascript = { 'prettierd', 'prettier', stop_after_first = true },
                    javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
                    typescript = { 'prettierd', 'prettier', stop_after_first = true },
                    typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
                    json = { 'prettierd', 'prettier', stop_after_first = true },
                    graphql = { 'prettierd', 'prettier', stop_after_first = true },
                },
                format_on_save = {
                    timeout_ms = 5000,
                    async = false,
                    lsp_format = 'fallback',
                },
            })
        end,
    },
    {
        'windwp/nvim-ts-autotag',
        config = function()
            require('nvim-ts-autotag').setup()
        end,
    },
    {
        'folke/trouble.nvim',
        cmd = 'Trouble',
        keys = {
            { '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>',                        desc = 'Diagnostics (Trouble)' },
            { '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',           desc = 'Buffer Diagnostics (Trouble)' },
            { '<leader>cs', '<cmd>Trouble symbols toggle focus=false<cr>',                desc = 'Symbols (Trouble)' },
            { '<leader>cl', '<cmd>Trouble lsp toggle focus=false win.position=right<cr>', desc = 'LSP Definitions / references / ... (Trouble)' },
            { '<leader>xL', '<cmd>Trouble loclist toggle<cr>',                            desc = 'Location List (Trouble)' },
            { '<leader>xQ', '<cmd>Trouble qflist toggle<cr>',                             desc = 'Quickfix List (Trouble)' },
        },
        config = function()
            require('trouble').setup()
        end,
    },
    {
        'CopilotC-Nvim/CopilotChat.nvim',
        dependencies = {
            { 'github/copilot.vim' },
            { 'nvim-lua/plenary.nvim', branch = 'master' },
        },
        build = 'make tiktoken',
        config = function()
            require('CopilotChat').setup()
        end,
    },
}
