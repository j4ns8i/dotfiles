vim.cmd.highlight 'clear'
vim.o.background = 'dark'

if vim.g.syntax_on then
  vim.cmd 'syntax reset'
end

vim.g.colors_name = 'justin'

local black       = 0;
local darkred     = 1;
local darkgreen   = 2;
local darkyellow  = 3;
local darkblue    = 4;
local darkmagenta = 5;
local darkcyan    = 6;
local lightgray   = 7;

local darkgray    = 8;
local red         = 9;
local green       = 10;
local yellow      = 11;
local blue        = 12;
local magenta     = 13;
local cyan        = 14;
local white       = 15;

local M = {
  black       = black,
  darkred     = darkred,
  darkgreen   = darkgreen,
  darkyellow  = darkyellow,
  darkblue    = darkblue,
  darkmagenta = darkmagenta,
  darkcyan    = darkcyan,
  lightgray   = lightgray,

  darkgray    = darkgray,
  red         = red,
  green       = green,
  yellow      = yellow,
  blue        = blue,
  magenta     = magenta,
  cyan        = cyan,
  white       = white,
}

local function hi(name, opts)
  vim.api.nvim_set_hl(0, name, opts)
end

M.hi = hi

hi('Normal',             { ctermfg = white })
hi('Pmenu',              { ctermfg = white })
hi('PmenuSel',           { ctermfg = black, ctermbg = darkblue })
hi('PmenuThumb',         { ctermbg = darkblue })
hi('WinSeparator',       { ctermfg = darkgray })

hi('Identifier',         { link = 'Normal' })
hi('Function',           { italic = true })
hi('Constant',           { ctermfg = darkyellow })
hi('Character',          { ctermfg = darkmagenta })
hi('Statement',          { ctermfg = darkcyan, bold = true })
hi('Keyword',            { ctermfg = darkcyan })
hi('Conditional',        { link = 'Keyword' })
hi('Boolean',            { link = 'Conditional' })
hi('Operator',           { link = 'Conditional' })
hi('Delimiter',          { ctermfg = darkmagenta })
hi('String',             { ctermfg = darkgreen })
hi('@lsp.type.string',   { link = 'String' })
hi('Number',             { ctermfg = darkyellow })
hi('Todo',               { italic = true, bold = true })
hi('Type',               { ctermfg = darkyellow })

hi('DiagnosticError',    { ctermfg = red, italic = true }) -- for diagnostics obvs
hi('DiagnosticWarn',     { ctermfg = yellow, italic = true })
hi('DiagnosticInfo',     { ctermfg = blue, italic = true })
hi('DiagnosticHint',     { ctermfg = lightgray, italic = true })
hi('DiagnosticOk',       { ctermfg = green, italic = true })
hi('ErrorMsg',           { ctermfg = red })  -- command line messages
hi('WarningMsg',         { ctermfg = yellow })
hi('Error',              { link = 'ErrorMsg' }) -- used infrequently (ex: luaParenError)

hi('Comment',            { ctermfg = lightgray })
hi('Ignore',             { link = 'Comment' })

hi('LineNr',             { ctermfg = darkgray })
hi('CursorLine',         { ctermbg = darkgray })
hi('CursorLineNr',       { ctermfg = lightgray })
hi('Cursor',             { ctermfg = lightgray })
hi('CursorColumn',       { ctermfg = white, ctermbg = darkgray })
hi('NonText',            { link = 'LineNr' })

hi('PreProc',            { ctermfg = yellow })

hi('Special',            { ctermfg = darkcyan })
hi('SpecialKey',         { link = 'Special' })
hi('Conceal',            { link = 'Special' })

hi('Underlined',         { underline = true })
hi('TabLine',            { ctermfg = lightgray })
hi('TabLineFill',        { ctermfg = lightgray })
hi('TabLineSel',         { ctermfg = darkblue })

hi('Title',              { ctermfg = darkcyan, bold = true })

hi('Visual',             { ctermfg = white, ctermbg = darkgray })
hi('IncSearch',          { ctermbg = darkcyan })
hi('Search',             { ctermfg = black, ctermbg = darkblue })

hi('Directory',          { ctermfg = darkblue })
hi('MatchParen',         { ctermfg = black, ctermbg = lightgray })
hi('ColorColumn',        { ctermfg = black, ctermbg = darkgray })
hi('SignColumn',         { ctermbg = black })

hi('Folded',             { ctermfg = darkmagenta })
hi('FoldColumn',         { ctermfg = darkmagenta })

hi('WildMenu',           { ctermbg = green, ctermfg = black })
hi('ModeMsg',            { ctermfg = darkgreen })

hi('Question',           { ctermfg = blue })
hi('MoreMsg',            { link = 'Question' })

hi('DiffAdd',            { ctermfg = darkgreen })
hi('DiffChange',         { ctermfg = lightgray })
hi('DiffDelete',         { ctermfg = darkred })
hi('DiffText',           { ctermfg = darkblue })

hi('htmlLink',           { ctermfg = darkred })
hi('htmlBold',           { ctermfg = darkred, bold = true })
hi('htmlItalic',         { ctermfg = darkred, italic = true })
hi('htmlTagName',        { ctermfg = darkblue })
hi('htmlTag',            { ctermfg = lightgray })
hi('htmlEndTag',         { link = 'htmlTag' })

return M
