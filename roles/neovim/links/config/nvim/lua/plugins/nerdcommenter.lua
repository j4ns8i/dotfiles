return {
  'preservim/nerdcommenter',
  keys = {
    { '<leader>c<space>', "<Plug>NERDCommenterToggle", { 'n', 'v' } }
  },
  config = function()
    vim.g.NERDSpaceDelims = 1
  end
}
