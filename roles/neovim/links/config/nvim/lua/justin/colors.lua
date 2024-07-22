vim.cmd.highlight 'clear'
vim.o.background = 'dark'

if vim.g.syntax_on then
  vim.cmd 'syntax reset'
end

vim.g.colors_name = 'justin'

local none        = 'none';

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

local M           = {
  black               = black,
  darkred             = darkred,
  darkgreen           = darkgreen,
  darkyellow          = darkyellow,
  darkblue            = darkblue,
  darkmagenta         = darkmagenta,
  darkcyan            = darkcyan,
  lightgray           = lightgray,

  darkgray            = darkgray,
  red                 = red,
  green               = green,
  yellow              = yellow,
  blue                = blue,
  magenta             = magenta,
  cyan                = cyan,
  white               = white,

  guiblack            = '#15171d',
  guired              = '#c45361',
  guigreen            = '#607f55',
  guiyellow           = '#d6ae86',
  guiblue             = '#4b799e',
  guimagenta          = '#9b68b3',
  guicyan             = '#487e6d',
  guilightgray        = '#5d6068',

  guidarkgray         = '#3b3e46',
  guidarkred          = '#d4737f',
  guidarkgreen        = '#90b782',
  guidarkyellow       = '#ffcda4',
  guidarkblue         = '#86a5be',
  guidarkmagenta      = '#8f729a',
  guidarkcyan         = '#76af9d',
  guiwhite            = '#c7d0e0',

  -- for more ui depth
  guidarkdarkgray     = '#2e3037',
  guidarkdarkdarkgray = '#1d1e24',
}

-- dynamic_colors offers a logical color table that changes values based on
-- termguicolors.
local function dynamic_colors()
  if vim.opt.termguicolors:get() then
    return {
      black            = M.guiblack,
      red              = M.guired,
      green            = M.guigreen,
      yellow           = M.guiyellow,
      blue             = M.guiblue,
      magenta          = M.guimagenta,
      cyan             = M.guicyan,
      lightgray        = M.guilightgray,

      darkgray         = M.guidarkgray,
      darkred          = M.guidarkred,
      darkgreen        = M.guidarkgreen,
      darkyellow       = M.guidarkyellow,
      darkblue         = M.guidarkblue,
      darkmagenta      = M.guidarkmagenta,
      darkcyan         = M.guidarkcyan,
      white            = M.guiwhite,

      darkdarkgray     = M.guidarkdarkgray,
      darkdarkdarkgray = M.guidarkdarkdarkgray,
    }
  else
    return {
      black            = M.black,
      red              = M.red,
      green            = M.green,
      yellow           = M.yellow,
      blue             = M.blue,
      magenta          = M.magenta,
      cyan             = M.cyan,
      lightgray        = M.lightgray,

      darkgray         = M.darkgray,
      darkred          = M.darkred,
      darkgreen        = M.darkgreen,
      darkyellow       = M.darkyellow,
      darkblue         = M.darkblue,
      darkmagenta      = M.darkmagenta,
      darkcyan         = M.darkcyan,
      white            = M.white,

      darkdarkgray     = M.darkgray,
      darkdarkdarkgray = M.black,
    }
  end
end

local function hi(name, opts)
  vim.api.nvim_set_hl(0, name, opts)
end

hi('Normal',       { ctermfg = white,    fg = M.guiwhite })
hi('Pmenu',        { ctermfg = white,    fg = M.guiwhite })
hi('PmenuSel',     { ctermfg = black,    ctermbg = darkblue, fg = M.guiblack, bg = M.guidarkblue })
hi('PmenuThumb',   { ctermbg = darkblue, bg = M.guidarkblue })
hi('WinSeparator', { ctermfg = darkgray, fg = M.guidarkgray })
hi('NormalFloat',  { ctermbg = black,    bg = M.guiblack })

hi('Identifier',       { ctermfg = white,       fg = M.guiwhite })
hi('Function',         { italic = true })
hi('Constant',         { ctermfg = darkyellow,  fg = M.guidarkyellow })
hi('Character',        { ctermfg = darkmagenta, fg = M.guidarkmagenta })
hi('Statement',        { ctermfg = darkcyan,    fg = M.guidarkcyan, bold = true })
hi('Keyword',          { ctermfg = darkcyan,    fg = M.guidarkcyan, bold = true })
hi('Conditional',      { link = 'Keyword' })
hi('Boolean',          { link = 'Conditional' })
hi('Operator',         { link = 'Conditional' })
hi('Delimiter',        { ctermfg = darkmagenta, fg = M.guidarkmagenta })
hi('String',           { ctermfg = darkgreen,   fg = M.guidarkgreen })
hi('@lsp.type.string', { link = 'String' })
hi('Number',           { ctermfg = darkyellow,  fg = M.guidarkyellow })
hi('Todo',             { italic = true,         bold = true })
hi('Type',             { ctermfg = darkyellow,  fg = M.guidarkyellow })

hi('DiagnosticError', { ctermfg = red,       italic = true, fg = M.guired }) -- for diagnostics obvs
hi('DiagnosticWarn',  { ctermfg = yellow,    italic = true, fg = M.guiyellow })
hi('DiagnosticInfo',  { ctermfg = blue,      italic = true, fg = M.guiblue })
hi('DiagnosticHint',  { ctermfg = lightgray, italic = true, fg = M.guilightgray })
hi('DiagnosticOk',    { ctermfg = green,     italic = true, fg = M.guigreen })
hi('ErrorMsg',        { ctermfg = red,       fg = M.guired }) -- command line messages
hi('Error',           { link = 'ErrorMsg' }) -- used infrequently (ex: luaParenError)
hi('WarningMsg',      { ctermfg = yellow,    fg = M.guiyellow })

hi('Comment', { ctermfg = lightgray, fg = M.guilightgray })
hi('Ignore',  { link = 'Comment' })

hi('LineNr',       { ctermfg = darkgray,  fg = M.guidarkgray })
hi('CursorLine',   { ctermbg = darkgray,  bg = M.guidarkdarkdarkgray })
hi('CursorLineNr', { ctermfg = lightgray, fg = M.guilightgray })
hi('Cursor',       { ctermfg = lightgray, fg = M.guilightgray })
hi('CursorColumn', { ctermfg = white,     ctermbg = darkgray, fg = M.guiwhite, bg = M.guidarkgray })
hi('NonText',      { link = 'LineNr' })

hi('PreProc', { ctermfg = yellow, fg = M.guiyellow })

hi('Special',    { ctermfg = darkcyan, fg = M.guidarkcyan })
hi('SpecialKey', { link = 'Special' })
hi('Conceal',    { link = 'Special' })

hi('Underlined',  { underline = true })
hi('TabLine',     { ctermfg = lightgray, fg = M.guilightgray })
hi('TabLineFill', { ctermfg = lightgray, fg = M.guilightgray })
hi('TabLineSel',  { ctermfg = darkblue,  fg = M.guidarkblue })

hi('Title',     { ctermfg = darkcyan, bold = true,        fg = M.guidarkcyan })
hi('Visual',    { ctermfg = white,    ctermbg = darkgray, fg = M.guiwhite, bg = M.guidarkgray })
hi('IncSearch', { ctermfg = black,    ctermbg = darkblue, fg = M.guiblack, bg = M.guidarkblue })
hi('Search',    { ctermfg = black,    ctermbg = blue, fg = M.guiblack, bg = M.guiblue })
hi('CurSearch', { link = 'IncSearch' })

hi('Directory',   { ctermfg = darkblue, fg = M.guidarkblue })
hi('MatchParen',  { reverse = true })
hi('ColorColumn', { ctermbg = darkgray, bg = M.guidarkdarkdarkgray })
hi('SignColumn',  { ctermbg = none,     bg = M.guinone })

hi('Folded',     { ctermfg = darkmagenta, fg = M.guidarkmagenta })
hi('FoldColumn', { ctermfg = darkmagenta, fg = M.guidarkmagenta })

hi('WildMenu', { ctermbg = green,     ctermfg = black, bg = M.guigreen, fg = M.guiblack })
hi('ModeMsg',  { ctermfg = darkgreen, fg = M.guidarkgreen })
hi('Question', { ctermfg = blue,      fg = M.guiblue })
hi('MoreMsg',  { link = 'Question' })

hi('DiffAdd',    { ctermfg = darkgreen,  fg = M.guidarkgreen })
hi('DiffChange', { ctermfg = darkyellow, fg = M.guidarkyellow })
hi('DiffDelete', { ctermfg = darkred,    fg = M.guidarkred })
hi('DiffText',   { ctermfg = darkblue,   fg = M.guidarkblue })
hi('Added',      { link = 'DiffAdd' })
hi('Removed',    { link = 'DiffDelete' })

hi('htmlLink', { ctermfg = darkred, fg = M.guidarkred })
hi('htmlBold', { ctermfg = darkred, bold = true, fg = M.guidarkred })
hi('htmlItalic', { ctermfg = darkred, italic = true, fg = M.guidarkred })
hi('htmlTagName', { ctermfg = darkblue, fg = M.guidarkblue })
hi('htmlTag', { ctermfg = lightgray, fg = M.guilightgray })
hi('htmlEndTag', { link = 'htmlTag' })

M.dyn = dynamic_colors()
M.hi = hi
return M
