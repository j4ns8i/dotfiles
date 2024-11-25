local function hi(name, args)
  vim.api.nvim_set_hl(0, name, args)
end

vim.cmd.colorscheme 'base16-nord'
local colors = require('base16-colorscheme').colors

-- From https://github.com/chriskempson/base16/blob/main/styling.md:
--
-- base00 - Default Background
-- base01 - Lighter Background (Used for status bars, line number and folding marks)
-- base02 - Selection Background
-- base03 - Comments, Invisibles, Line Highlighting
-- base04 - Dark Foreground (Used for status bars)
-- base05 - Default Foreground, Caret, Delimiters, Operators
-- base06 - Light Foreground (Not often used)
-- base07 - Light Background (Not often used)
-- base08 - Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
-- base09 - Integers, Boolean, Constants, XML Attributes, Markup Link Url
-- base0A - Classes, Markup Bold, Search Text Background
-- base0B - Strings, Inherited Class, Markup Code, Diff Inserted
-- base0C - Support, Regular Expressions, Escape Characters, Markup Quotes
-- base0D - Functions, Methods, Attribute IDs, Headings
-- base0E - Keywords, Storage, Selector, Markup Italic, Diff Changed
-- base0F - Deprecated, Opening/Closing Embedded Language Tags, e.g. <?php ?>

hi('DiffChange', { fg = colors.base0A })
hi('DiagnosticHint', { fg = colors.base03 })
hi('FloatBorder', { fg = colors.base02 })

hi('LineNr', { fg = colors.base03 })

hi('TSNamespace', { fg = colors.base0A })
hi('TSVariable', { fg = colors.base04 })

hi('@constant', { fg = colors.base08 })
hi('@lsp.mod.readonly', { link = '@constant' })
