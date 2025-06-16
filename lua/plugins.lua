-- ~/.config/nvim/lua/plugins.lua

-- Lazy.nvim plugin specification
-- This is where you define all your plugins.

require('lazy').setup({
  -- Plugin 'github/copilot.vim'
  { 'github/copilot.vim' },
  { 'williamboman/mason.nvim',
  lazy = false, -- Load this plugin immediately
  config = function()
      require('mason').setup({
          -- You can add configuration options here if needed
      })
  end,
  },
  { 'williamboman/mason-lspconfig.nvim',
  lazy = false, -- Load this plugin immediately
  dependencies = { 'neovim/nvim-lspconfig' }, -- Ensure nvim-lspconfig is loaded
  opts = {
      auto_install = true, -- Automatically install LSP servers
  },
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup({
        options = {
          icons_enabled = true,
          theme = 'gruvbox', -- Replaces vim.g.airline_theme = 'simple'
          -- Other options like component_separators, section_separators, etc.
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = {
            -- Replicates vim.g.airline_section_b
            {
              function()
                return 'BN: ' .. vim.api.nvim_buf_get_number(0)
              end,
              color = { fg = '#bb992a' }, -- Example color, adjust as needed
            },
            'branch',
            'diff',
          },
          lualine_c = { 'filename' },
          lualine_x = { 'diagnostics', 'encoding', 'fileformat', 'filetype' },
          lualine_y = {
            -- Replicates vim.g.airline_section_y
            {
              function()
                return os.date('%c') -- Format as per %c in strftime
              end,
              color = { fg = '#99bb2a' }, -- Example color, adjust as needed
            },
            'progress'
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
      'nvim-telescope/telescope.nvim', tag = '0.1.8',
      -- or                              , branch = '0.1.x',
      dependencies = { 'nvim-lua/plenary.nvim', {'nvim-telescope/telescope-fzf-native.nvim', build = 'make' } },
        config = function()
            -- Key mappings for Telescope
            vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files)
            vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep) 
            vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers) 
            vim.keymap.set('n', '<leader>fc', require('telescope.builtin').commands) 
        end
  },

  -- Plugin 'mattn/emmet-vim'
  { 'mattn/emmet-vim' },

  -- Plugin 'morhetz/gruvbox'
  { 'morhetz/gruvbox',
  -- Set the colorscheme in the 'config' function, so it runs AFTER the plugin is loaded.
  config = function()
      vim.cmd('colorscheme gruvbox')
  end,
  },
  {
      "vhyrro/luarocks.nvim",
      priority = 1000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
      config = true,
  }

  -- Plugin 'matchit' (often not needed with modern Neovim, but included as per .vimrc)
  -- This is a built-in plugin that needs to be 'packadd'ed.
  -- It's included here for completeness, though it's not a typical 'use' plugin for Lazy.nvim.
  -- It's handled by a direct vim.cmd in init.lua.
  -- { 'matchit' }, -- Not needed here, as it's a built-in runtime plugin.
}, {
  -- Lazy.nvim configuration options
  -- You can add more options here, e.g., for auto-updates.
  -- For example, to automatically check for plugin updates every 7 days:
  -- checker = {
  --   enabled = true,
  --   frequency = 60 * 60 * 24 * 7, -- Every 7 days
  -- },
})

-- After plugins are set up, you might want to ensure matchit is loaded.
-- This is typically handled by Neovim's runtimepath, but if you had issues,
-- you could explicitly add it.
-- vim.cmd('packadd! matchit') -- This line is already in init.lua if needed.
