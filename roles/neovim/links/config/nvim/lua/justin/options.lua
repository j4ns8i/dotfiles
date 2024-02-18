vim.cmd.filetype 'plugin on' -- Ensure filetype plugins are enabled
vim.o.updatetime = 50        -- Update every 100ms (default is 4s)

-- TODO read truecolors from file rather than relying on cterm colors. This
-- has the benefit of allowing more than just 16 colors
-- vim.o.termguicolors = true

vim.o.relativenumber = true    -- Show relative line numbers
vim.o.number         = true    -- But still show current line number
vim.o.signcolumn     = 'yes:1' -- Always show 1 (pair of) columns for signs (gitgutter)

vim.o.wrap      = false
vim.o.listchars = 'tab:  ,trail:·,extends:»,nbsp:␣'
vim.o.list      = true

vim.o.ignorecase = true -- Ignore cases in search
vim.o.smartcase  = true -- unless different cases are used

vim.o.linebreak   = true    -- Break at reasonable characters (see 'breakat')
vim.o.breakindent = true    -- Indent broken lines accordingly
vim.o.showbreak   = '  \\ ' -- Format line breaks

vim.o.scrolloff = 3 -- Start scrolling before cursor hits top/bottom

-- When splitting windows, keep what you're working on in the "main" position
vim.o.splitbelow = true
vim.o.splitright = true

vim.o.expandtab = true -- Use spaces instead of tabs

vim.o.shiftwidth  = 4
vim.o.tabstop     = 4
vim.o.softtabstop = 4

vim.o.smartindent = true

vim.o.foldmethod = 'indent' -- Fold based on indent level
vim.o.foldlevel  = 99       -- Start with all folds expanded

vim.opt.nrformats:append { 'alpha' } -- Add or subtract letters with ctrl-a / ctrl-x

vim.o.textwidth = 80 -- 80 is just a good width, ok?

vim.opt.formatoptions:append { 'a', 'r', }

vim.o.undofile = true -- Persist undo information

-- Sometimes I like to wipe out ~/.local/state/nvim for testing installations
-- and whatnot. I don't want to lose my undo history just because of that.
vim.o.undodir = vim.fs.normalize('~/.nvim-undo')

vim.o.hlsearch = false -- Don't highlight searches after execution

vim.o.cursorline = true
