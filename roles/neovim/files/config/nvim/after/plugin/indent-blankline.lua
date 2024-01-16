require('ibl').setup({
  indent = {
    char = '┆'
  },
  scope = {
    enabled = false
  }
})

vim.api.nvim_set_hl(0, 'IblIndent',          { ctermfg = 'DarkGray', ctermbg = 'None' })
vim.api.nvim_set_hl(0, 'IblWhitespace',      { ctermfg = 'DarkGray', ctermbg = 'None' })
vim.api.nvim_set_hl(0, '@ibl.indent.char.1', { ctermfg = 'DarkGray', ctermbg = 'None' })
