return {
  'preservim/nerdcommenter',
  config = function()
    vim.g.NERDSpaceDelims = 1
    vim.keymap.set({'n', 'v'}, '<leader>c<space>', "<Plug>NERDCommenterToggle")
  end
}
