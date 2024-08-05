return {
  'lukas-reineke/indent-blankline.nvim',
  config = function()
    local c = require('justin.colors')
    c.hi('IblIndent', { ctermfg = c.darkgray, fg = c.guidarkdarkgray })
    c.hi('@ibl.indent.char.1', { link = 'IblIndent' })
    require('ibl').setup({
      indent = {
        char     = '│',
        tab_char = '│',
      },
      scope = { enabled = false },
    })
  end
}
