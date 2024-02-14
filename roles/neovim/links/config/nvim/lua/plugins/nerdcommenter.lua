return {
  'preservim/nerdcommenter',
  keys = {
    { '<leader>c<space>', "<Plug>NERDCommenterToggle", mode = { 'n', 'v' } },
  },
  config = function()
    vim.g.NERDSpaceDelims = 1
  end
}
