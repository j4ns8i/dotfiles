return {
  'lukas-reineke/indent-blankline.nvim',
  opts = function()
    return {
      indent = { char = '┆' },
      scope = { enabled = false },
    }
  end,
  config = function (_, opts)
    require('ibl').setup(opts)
    local c = require('justin.colors')
    c.hi('IblIndent',          { ctermfg = c.darkgray })
    c.hi('@ibl.indent.char.1', { link = 'IblIndent' })
  end
}
