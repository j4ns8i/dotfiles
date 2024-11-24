local function hi(name, args)
  vim.api.nvim_set_hl(0, name, args)
end

vim.cmd.colorscheme 'base16-nord'
local colors = require('base16-colorscheme').colors

hi('DiffChange', { fg = colors.base0A })
hi('DiagnosticHint', { fg = colors.base03 })
hi('FloatBorder', { fg = colors.base02 })

hi('TSNamespace', { fg = colors.base0A })
hi('TSVariable', { fg = colors.base04 })

hi('@constant', { fg = colors.base08 })
hi('@lsp.mod.readonly', { link = '@constant' })
