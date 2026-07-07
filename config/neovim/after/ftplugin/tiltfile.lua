vim.bo.commentstring = '# %s'

vim.b.undo_ftplugin = 'setlocal cms<'

-- Tiltfiles are written in Starlark. Tell treesitter to use the starlark
-- parser for the (built-in) tiltfile filetype, then start highlighting --
-- the global FileType autocmd in treesitter.lua only fires for parser names,
-- not for `tiltfile`.
vim.treesitter.language.register('starlark', 'tiltfile')
vim.treesitter.start()
