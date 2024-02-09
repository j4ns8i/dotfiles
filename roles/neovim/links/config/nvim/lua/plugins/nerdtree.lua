return {
  'preservim/nerdtree',
  config = function()
    vim.keymap.set('n', '<leader>ntf', vim.cmd.NERDTreeFind)
    vim.keymap.set('n', '<leader>pv', vim.cmd.NERDTreeFocus)

    -- If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
    vim.cmd [[
      autocmd BufEnter * if winnr() == winnr('h') && bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
        \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif
    ]]
  end
}
