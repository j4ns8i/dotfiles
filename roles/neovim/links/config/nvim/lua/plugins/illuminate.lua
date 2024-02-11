local filetypes = {
  'lua',
  'javascript',
  'jsx',
  'typescript',
  'css',
  'go',
  'rust',
  'python',
  'make',
}

return {
  'RRethy/vim-illuminate',
  opts = {
    filetypes_allowlist = filetypes,
    filetypes_denylist = {},
    min_count_to_highlight = 2,
  },
  ft = filetypes,
  config = function(_, opts)
    require('illuminate').configure(opts)
  end
}
