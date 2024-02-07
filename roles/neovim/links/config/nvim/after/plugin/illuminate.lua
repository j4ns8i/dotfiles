require('illuminate').configure({
  min_count_to_highlight = 2,
  filetypes_denylist = {},
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
})
