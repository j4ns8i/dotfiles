return {
  'tpope/vim-fugitive',
  config = function ()
    vim.keymap.set('n', '<leader>gb', ':Git blame<cr>')
    vim.keymap.set('n', '<leader>gcv', ':Gvdiffsplit!<cr>') -- (g)it (c)onflict resolve (v)ertical
  end
}
