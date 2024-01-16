vim.keymap.set('n', '<leader>ntf', ':NERDTreeFind<cr>')

-- If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
vim.cmd [[
  autocmd BufEnter * if winnr() == winnr('h') && bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif
]]

-- Open the existing NERDTree on each new tab.
vim.cmd [[
  autocmd BufWinEnter * if &buftype != 'quickfix' && getcmdwintype() == '' | silent NERDTreeMirror | endif
]]
