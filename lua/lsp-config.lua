-- ~/.config/nvim/lua/lsp-config.lua

local lspconfig = require('lspconfig')

-- Function to set up LSP servers

local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- lua ls
lspconfig.lua_ls.setup{
    capabilities = capabilities,
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }, -- Recognize 'vim' as a global variable
            },
            workspace = {
                checkThirdParty = false, -- Disable third-party checks
            },
            telemetry = {
                enable = false, -- Disable telemetry
            },
        },
    },
}

-- tailwindcss
lspconfig.tailwindcss.setup{
    capabilities = capabilities,
    filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "elixir", "heex" }, -- Add relevant filetypes
    root_dir = lspconfig.util.root_pattern("tailwind.config.js", "tailwind.config.ts", "package.json"),
    settings = {
        tailwindCSS = {
            experimental = {
                classRegex = { [[class="([^"]*)]], [[className="([^"]*)"]] }, -- Support class and className
            },
            includeLanguages = {
                elixir = "html-eex",
                heex = "html-eex",
            },
        },
    },
}
