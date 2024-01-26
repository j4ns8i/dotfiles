require('ibl').setup({
  indent = {
    char = '┆'
  },
  scope = {
    enabled = false
  }
})

vim.api.nvim_set_hl(0, 'IblIndent',          { ctermfg = 8, ctermbg = 'None' })
vim.api.nvim_set_hl(0, 'IblWhitespace',      { ctermfg = 8, ctermbg = 'None' })
vim.api.nvim_set_hl(0, '@ibl.indent.char.1', { ctermfg = 8, ctermbg = 'None' })
