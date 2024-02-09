return {
  'RRethy/vim-illuminate',
  opts = {
    filetypes_allowlist = {
      'lua',
      'javascript',
      'jsx',
      'typescript',
      'css',
      'go',
      'rust',
      'python',
      'make',
    },
    filetypes_denylist = {},
    min_count_to_highlight = 2,
  },
  config = function(_, opts)
    require('illuminate').configure(opts)
  end
}
