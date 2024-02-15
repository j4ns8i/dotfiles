return {
  'tpope/vim-fugitive',
  keys = {
    { 'gb',  '<cmd>Git blame<cr>' },
    { 'gcv', '<cmd>Gvdiffsplit!<cr>' }, -- (g)it (c)onflict resolve (v)ertical
    { 'gch', '<cmd>Gdiffsplit!<cr>' },  -- (g)it (c)onflict resolve (h)orizontal
  },
  cmd = {
    'Git',
    'Gvdiffsplit',
    'Gdiffsplit',
  },
}
