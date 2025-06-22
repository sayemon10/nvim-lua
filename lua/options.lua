-- ~/.config/nvim/lua/options.lua

-- General Neovim options
-- Equivalent to 'set' commands in .vimrc

-- Basic Editing and Display
vim.opt.autoindent = true             -- Copy indent from current line when starting a new line
vim.opt.background = 'dark'           -- Set background to dark (for gruvbox theme)
vim.opt.backspace = 'indent,eol,start'-- Allow backspacing over autoindent, line breaks, and insert-mode start
vim.opt.colorcolumn = '80'            -- Highlight column 80
vim.opt.complete = 'kspell'           -- Add spell checking to keyword completion
vim.opt.clipboard = 'unnamedplus'     -- Use system clipboard for all yank, delete, change and put operations
vim.opt.encoding = 'UTF-8'            -- Set encoding to UTF-8
vim.opt.expandtab = true              -- Use spaces instead of tabs
vim.opt.foldenable = true             -- Enable code folding
vim.opt.hidden = true                 -- Hide buffers instead of closing them
vim.opt.history = 1000                -- Number of commands to remember in history
vim.opt.incsearch = true              -- Highlight matches as you type
vim.opt.laststatus = 2                -- Always show the status line
vim.opt.listchars = 'trail:-'         -- Show trailing whitespace as '-'
vim.opt.mouse = 'a'                   -- Enable mouse support in all modes
vim.opt.backup = false                -- Do not create backup files (was nobackup)
-- vim.opt.nocompatible = true           -- Behave like Vim, not Vi (essential for Neovim)
vim.opt.swapfile = false              -- Do not create swap files (was noswapfile)
vim.opt.writebackup = false           -- Do not create backup files when overwriting (was nowritebackup)
vim.opt.path:append { '**' }          -- Add current directory and subdirectories to path for file searching
vim.opt.number = true                 -- Show absolute line numbers
vim.opt.relativenumber = true         -- Show relative line numbers
vim.opt.ruler = true                  -- Show current position in the status line
vim.opt.shiftwidth = 4                -- Number of spaces to use for autoindenting
vim.opt.shortmess:append 'I'          -- Don't show the intro message
vim.opt.showcmd = true                -- Show (partial) command in status line
vim.opt.showmode = true               -- Show current mode in status line
vim.opt.signcolumn = 'yes'            -- Always show the sign column (for LSP diagnostics, git signs)
vim.opt.smartindent = true            -- Smart autoindenting
vim.opt.smarttab = true               -- Smart tab handling
vim.opt.smoothscroll = true           -- Enable smooth scrolling (if supported by terminal)
vim.opt.softtabstop = 2               -- Number of spaces a Tab counts for while editing
vim.opt.statusline = ''               -- Clear default statusline (airline/lualine will manage it)
vim.opt.termguicolors = true          -- Enable true colors if your terminal supports it
vim.opt.tabstop = 2                   -- Number of spaces a Tab character represents
vim.opt.title = true                  -- Show current file in window title
vim.opt.ttyfast = true                -- Assume a fast terminal connection
vim.opt.virtualedit = 'all'           -- Allow cursor to move anywhere
vim.opt.wildignore:append {           -- Files/directories to ignore in tab completion
  '*.exe', '*.dll', '*.pdb',
  '*/node_modules/*', '.next/*', '.git/*',
}
vim.opt.wildoptions = 'pum'           -- Show completion in a pop-up menu
vim.opt.wildmenu = true               -- Enable wildmenu for command-line completion

-- GUI Cursor (for Neovim-qt or similar GUI frontends)
-- This might not apply if you're purely in a terminal, but it's harmless.
vim.opt.guicursor = 'n-v-c-i:block'
vim.opt.guioptions:remove('T') -- Remove toolbar
vim.opt.guioptions:remove('m') -- Remove menu bar
vim.opt.guioptions:remove('r') -- Remove right scrollbar

-- Shell settings (ensure this matches your system's shell)
-- The user provided /bin/bash, so defaulting to that.
vim.opt.shell = '/bin/bash'
vim.opt.shellcmdflag = '-c'
vim.opt.shellquote = ''
vim.opt.shellxquote = ''

-- Plugin-specific global variables (equivalent to 'let g:...')
vim.g.user_emmet_leader_key = '<C-X>'

-- Diagnostic display inline
vim.diagnostic.config({
  virtual_text = true,
  underline = true
})
