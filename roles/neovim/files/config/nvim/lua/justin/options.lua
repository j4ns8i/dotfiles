vim.cmd.colorscheme 'wal'

-- vim.g.netrw_browse_split = 3 -- Open up NetRW selections as new tabs
-- vim.g.netrw_winsize = 30     -- Set listing window size to 30% when splitting
-- vim.g.netrw_preview = 1      -- Split preview vertically
-- vim.g.netrw_liststyle = 0    -- Tree view listing
-- vim.g.netrw_alto = 0
-- vim.g.netrw_altv = 0

vim.cmd.filetype 'plugin on' -- Ensure filetype plugins are enabled
vim.o.updatetime = 100       -- Update every 100ms (default is 4s)

vim.o.relativenumber = true   -- Show relative line numbers
vim.o.number = true           -- But still show current line number
vim.go.signcolumn = 'yes:1'   -- Always show 1 (pair of) columns for signs (gitgutter)

vim.o.ignorecase = true -- Ignore cases in search
vim.o.smartcase = true  -- unless different cases are used

vim.o.linebreak = true    -- Break at reasonable characters (see 'breakat')
vim.o.breakindent = true  -- Indent broken lines accordingly
vim.o.showbreak = '  \\ ' -- Format line breaks

vim.o.scrolloff=8 -- Start scrolling before cursor hits top/bottom

-- When splitting windows, keep what you're working on in the "main" position
vim.o.splitbelow = true
vim.o.splitright = true

vim.o.expandtab = true -- Use spaces instead of tabs

vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.softtabstop = 4

vim.o.foldmethod = 'indent' -- Fold based on indent level
vim.o.foldlevel = 99        -- Start with all folds expanded

vim.opt.nrformats:append { 'alpha' } -- Add or subtract letters with ctrl-a / ctrl-x

vim.o.undofile = true -- Persist undo information

vim.o.hlsearch = false -- Don't highlight searches after execution
-- vim.o.ffs?
-- vim.o.tags?
