require('illuminate').configure({
  filetypes_denylist = {
    'help',
    'qf', -- quickfix
    'fugitiveblame',
    'gitcommit',
    'lspinfo',
    'diff',
  },
})
