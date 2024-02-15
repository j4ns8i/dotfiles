" wal.vim -- Vim color scheme.
" Author:       Dylan Araps
" Webpage:      https://github.com/dylanaraps/wal
" Description:  A colorscheme that uses your terminal colors, made to work with 'wal'.

hi clear
set background=dark

if exists('syntax_on')
    syntax reset
endif

" Colorscheme name
let g:colors_name = 'wal'

" highlight groups {{{

" set t_Co=16
hi Normal ctermbg=NONE ctermfg=White cterm=NONE
hi! link Identifier Normal
hi NormalFloat ctermbg=Black
hi NonText ctermbg=NONE ctermfg=DarkCyan cterm=NONE
hi Comment ctermbg=NONE ctermfg=7 cterm=NONE
hi Function cterm=italic
hi Constant ctermbg=NONE ctermfg=DarkYellow cterm=NONE
hi Error ctermbg=NONE ctermfg=Red cterm=NONE
hi! link DiagnosticError Error
hi Ignore ctermbg=7 ctermfg=Black cterm=NONE
hi PreProc ctermbg=NONE ctermfg=DarkYellow cterm=NONE
hi Special ctermbg=NONE ctermfg=DarkCyan cterm=NONE
    hi! link Conceal Special
hi Statement ctermbg=NONE ctermfg=DarkCyan cterm=bold
hi Keyword ctermbg=NONE ctermfg=DarkCyan cterm=NONE
    hi! link Conditional Keyword
hi String ctermbg=NONE ctermfg=DarkGreen cterm=NONE
    hi link @lsp.type.string String
hi Number ctermbg=NONE ctermfg=DarkYellow cterm=NONE
hi Todo cterm=italic,bold
hi Type ctermbg=NONE ctermfg=DarkYellow cterm=NONE
hi Underlined ctermbg=NONE ctermfg=Red cterm=underline
hi StatusLine ctermbg=White ctermfg=Black cterm=NONE
hi StatusLineNC ctermbg=NONE ctermfg=NONE cterm=NONE
hi TabLine ctermbg=NONE ctermfg=7 cterm=NONE
hi TabLineFill ctermbg=NONE ctermfg=7 cterm=NONE
hi TabLineSel ctermbg=DarkBlue ctermfg=Black cterm=NONE
hi TermCursorNC ctermbg=DarkYellow ctermfg=Black cterm=NONE
hi VertSplit ctermbg=NONE ctermfg=NONE cterm=NONE
hi Title ctermbg=NONE ctermfg=DarkCyan cterm=underline
hi LineNr ctermbg=NONE ctermfg=8 cterm=NONE
hi CursorLine ctermbg=8 cterm=NONE
hi CursorLineNr ctermbg=NONE ctermfg=7 cterm=NONE
hi helpLeadBlank ctermbg=NONE ctermfg=White cterm=NONE
hi helpNormal ctermbg=NONE ctermfg=White cterm=NONE
hi helpCommand ctermfg=Blue
hi helpExample ctermfg=Green
hi Visual ctermbg=7 ctermfg=White cterm=NONE
hi VisualNOS ctermbg=NONE ctermfg=Red cterm=NONE
hi FoldColumn ctermbg=NONE ctermfg=White cterm=NONE
hi Folded ctermbg=NONE ctermfg=7 cterm=NONE
hi WildMenu ctermbg=DarkGreen ctermfg=Black cterm=NONE
hi SpecialKey ctermbg=NONE ctermfg=7 cterm=NONE
hi DiffAdd ctermbg=NONE ctermfg=DarkGreen cterm=NONE
    hi link @diff.plus.diff DiffAdd
hi DiffChange ctermbg=NONE ctermfg=7 cterm=NONE
hi DiffDelete ctermbg=NONE ctermfg=DarkRed cterm=NONE
    hi link @diff.minus.diff DiffDelete
hi DiffText ctermbg=NONE ctermfg=DarkBlue cterm=NONE
hi IncSearch ctermbg=DarkCyan ctermfg=Black cterm=NONE
hi Search ctermbg=DarkGreen ctermfg=Black cterm=NONE
hi Directory ctermbg=NONE ctermfg=DarkBlue cterm=NONE
hi MatchParen ctermbg=7 ctermfg=Black cterm=NONE
hi ColorColumn ctermbg=DarkBlue ctermfg=Black cterm=NONE
hi signColumn ctermbg=NONE ctermfg=DarkBlue cterm=NONE
hi ErrorMsg ctermbg=NONE ctermfg=DarkRed cterm=NONE
hi ModeMsg ctermbg=NONE ctermfg=DarkGreen cterm=NONE
hi MoreMsg ctermbg=NONE ctermfg=DarkGreen cterm=NONE
hi Question ctermbg=NONE ctermfg=DarkBlue cterm=NONE
hi WarningMsg ctermfg=Yellow cterm=italic
hi! link DiagnosticWarn WarningMsg
hi Cursor ctermbg=NONE ctermfg=7 cterm=NONE
hi Structure ctermbg=NONE ctermfg=DarkMagenta cterm=NONE
hi CursorColumn ctermbg=7 ctermfg=White cterm=NONE
hi ModeMsg ctermbg=NONE ctermfg=White cterm=NONE
hi SpellBad ctermbg=Red ctermfg=Black cterm=NONE
    hi link NeomakeError SpellBad
    hi link NeomakeErrorSign SpellBad
hi SpellCap ctermbg=NONE ctermfg=DarkBlue cterm=underline
    hi link NeomakeWarning SpellCap
    hi link NeomakeWarningSign SpellCap
hi SpellLocal ctermbg=NONE ctermfg=DarkMagenta cterm=underline
hi SpellRare ctermbg=NONE ctermfg=DarkCyan cterm=underline
hi Boolean ctermbg=NONE ctermfg=DarkMagenta cterm=NONE
hi Character ctermbg=NONE ctermfg=Red cterm=NONE
hi Define ctermbg=NONE ctermfg=DarkMagenta cterm=NONE
hi Delimiter ctermbg=NONE ctermfg=DarkMagenta cterm=NONE
hi Float ctermbg=NONE ctermfg=DarkMagenta cterm=NONE
hi Include ctermbg=Black ctermfg=DarkBlue cterm=NONE
hi Label ctermbg=NONE ctermfg=DarkYellow cterm=NONE
hi Operator ctermbg=NONE ctermfg=White cterm=NONE
hi Repeat ctermbg=NONE ctermfg=DarkYellow cterm=NONE
hi SpecialChar ctermbg=NONE ctermfg=DarkMagenta cterm=NONE
hi Tag ctermbg=NONE ctermfg=DarkYellow cterm=NONE
hi Typedef ctermbg=NONE ctermfg=DarkYellow cterm=NONE
hi vimUserCommand ctermbg=NONE ctermfg=Green cterm=bold
    hi link vimMap vimUserCommand
    hi link vimLet vimUserCommand
    hi link vimCommand vimUserCommand
    hi link vimFTCmd vimUserCommand
    hi link vimAutoCmd vimUserCommand
    hi link vimNotFunc vimUserCommand
hi vimNotation ctermbg=NONE ctermfg=DarkBlue cterm=NONE
hi vimMapModKey ctermbg=NONE ctermfg=DarkBlue cterm=NONE
hi vimBracket ctermbg=NONE ctermfg=White cterm=NONE
hi vimCommentString ctermbg=NONE ctermfg=7 cterm=NONE
hi link vimHyperTextJump vimHyperTextEntry
hi htmlLink ctermbg=NONE ctermfg=Red cterm=underline
hi htmlBold ctermbg=NONE ctermfg=DarkYellow cterm=NONE cterm=BOLD
hi htmlItalic ctermbg=NONE ctermfg=DarkMagenta cterm=ITALIC
hi htmlEndTag ctermbg=NONE ctermfg=White cterm=NONE
hi htmlTag ctermbg=NONE ctermfg=White cterm=NONE
hi htmlTagName ctermbg=NONE ctermfg=Red cterm=BOLD
hi htmlH1 ctermbg=NONE ctermfg=White cterm=NONE
    hi link htmlH2 htmlH1
    hi link htmlH3 htmlH1
    hi link htmlH4 htmlH1
    hi link htmlH5 htmlH1
    hi link htmlH6 htmlH1
hi cssMultiColumnAttr ctermbg=NONE ctermfg=DarkGreen cterm=NONE
    hi link cssFontAttr cssMultiColumnAttr
    hi link cssFlexibleBoxAttr cssMultiColumnAttr
hi cssBraces ctermbg=NONE ctermfg=White cterm=NONE
    hi link cssAttrComma cssBraces
hi cssValueLength ctermbg=NONE ctermfg=White cterm=NONE
hi cssUnitDecorators ctermbg=NONE ctermfg=White cterm=NONE
hi cssValueNumber ctermbg=NONE ctermfg=White cterm=NONE
    hi link cssValueLength cssValueNumber
hi cssNoise ctermbg=NONE ctermfg=7 cterm=NONE
hi cssTagName ctermbg=NONE ctermfg=Red cterm=NONE
hi cssFunctionName ctermbg=NONE ctermfg=DarkBlue cterm=NONE
hi scssSelectorChar ctermbg=NONE ctermfg=White cterm=NONE
hi scssAttribute ctermbg=NONE ctermfg=White cterm=NONE
    hi link scssDefinition cssNoise
hi sassidChar ctermbg=NONE ctermfg=Red cterm=NONE
hi sassClassChar ctermbg=NONE ctermfg=DarkMagenta cterm=NONE
hi sassInclude ctermbg=NONE ctermfg=DarkMagenta cterm=NONE
hi sassMixing ctermbg=NONE ctermfg=DarkMagenta cterm=NONE
hi sassMixinName ctermbg=NONE ctermfg=DarkBlue cterm=NONE
hi javaScript ctermbg=NONE ctermfg=White cterm=NONE
hi javaScriptBraces ctermbg=NONE ctermfg=White cterm=NONE
hi javaScriptNumber ctermbg=NONE ctermfg=DarkMagenta cterm=NONE
hi markdownH1 ctermbg=NONE ctermfg=White cterm=NONE
    hi link markdownH2 markdownH1
    hi link markdownH3 markdownH1
    hi link markdownH4 markdownH1
    hi link markdownH5 markdownH1
    hi link markdownH6 markdownH1
hi markdownAutomaticLink ctermbg=NONE ctermfg=Red cterm=underline
    hi link markdownUrl markdownAutomaticLink
hi markdownError ctermbg=NONE ctermfg=White cterm=NONE
hi markdownCode ctermbg=NONE ctermfg=DarkYellow cterm=NONE
hi markdownCodeBlock ctermbg=NONE ctermfg=DarkYellow cterm=NONE
hi markdownCodeDelimiter ctermbg=NONE ctermfg=DarkMagenta cterm=NONE
hi xdefaultsValue ctermbg=NONE ctermfg=White cterm=NONE
hi rubyInclude ctermbg=NONE ctermfg=DarkBlue cterm=NONE
hi rubyDefine ctermbg=NONE ctermfg=DarkMagenta cterm=NONE
hi rubyFunction ctermbg=NONE ctermfg=DarkBlue cterm=NONE
hi rubyStringDelimiter ctermbg=NONE ctermfg=DarkGreen cterm=NONE
hi rubyInteger ctermbg=NONE ctermfg=DarkYellow cterm=NONE
hi rubyAttribute ctermbg=NONE ctermfg=DarkBlue cterm=NONE
hi rubyConstant ctermbg=NONE ctermfg=DarkYellow cterm=NONE
hi rubyInterpolation ctermbg=NONE ctermfg=DarkGreen cterm=NONE
hi rubyInterpolationDelimiter ctermbg=NONE ctermfg=DarkYellow cterm=NONE
hi rubyRegexp ctermbg=NONE ctermfg=DarkCyan cterm=NONE
hi rubySymbol ctermbg=NONE ctermfg=DarkGreen cterm=NONE
hi rubyTodo ctermbg=NONE ctermfg=7 cterm=NONE
hi rubyRegexpAnchor ctermbg=NONE ctermfg=White cterm=NONE
    hi link rubyRegexpQuantifier rubyRegexpAnchor
hi pythonOperator ctermbg=NONE ctermfg=DarkMagenta cterm=NONE
hi pythonFunction ctermbg=NONE ctermfg=DarkBlue cterm=NONE
hi pythonRepeat ctermbg=NONE ctermfg=DarkMagenta cterm=NONE
hi pythonStatement ctermbg=NONE ctermfg=Red cterm=Bold
hi pythonBuiltIn ctermbg=NONE ctermfg=DarkBlue cterm=NONE
hi phpMemberSelector ctermbg=NONE ctermfg=White cterm=NONE
hi phpComparison ctermbg=NONE ctermfg=White cterm=NONE
hi phpParent ctermbg=NONE ctermfg=White cterm=NONE
hi cOperator ctermbg=NONE ctermfg=DarkCyan cterm=NONE
hi cPreCondit ctermbg=NONE ctermfg=DarkMagenta cterm=NONE
hi SignifySignAdd ctermbg=NONE ctermfg=DarkGreen cterm=NONE
hi SignifySignChange ctermbg=NONE ctermfg=DarkBlue cterm=NONE
hi SignifySignDelete ctermbg=NONE ctermfg=Red cterm=NONE
hi NERDTreeDirSlash ctermbg=NONE ctermfg=DarkBlue cterm=NONE
hi NERDTreeExecFile ctermbg=NONE ctermfg=White cterm=NONE
hi ALEErrorSign ctermbg=NONE ctermfg=Red cterm=NONE
hi ALEWarningSign ctermbg=NONE ctermfg=DarkYellow cterm=NONE
hi ALEError ctermbg=NONE ctermfg=Red cterm=NONE
hi ALEWarning ctermbg=NONE ctermfg=DarkYellow cterm=NONE
hi SignColumn ctermbg=NONE
hi GitGutterAdd ctermfg=DarkGreen ctermbg=NONE
hi GitGutterChange ctermfg=DarkYellow ctermbg=NONE
hi GitGutterDelete ctermfg=DarkRed ctermbg=NONE
hi DiagnosticSignError ctermfg=Red ctermbg=NONE cterm=bold
hi link EndOfBuffer LineNr

hi Pmenu ctermfg=White ctermbg=Black
hi PmenuSel ctermfg=White ctermbg=7
hi PmenuSbar ctermbg=Yellow ctermfg=White
hi PmenuThumb ctermbg=7 ctermfg=White

hi FloatBorder ctermfg=7

hi CmpItemAbbrDeprecated ctermfg=7
hi CmpItemAbbrMatch cterm=bold
    hi link CmpItemAbbrMatchFuzzy CmpItemAbbrMatch
hi CmpItemKindField ctermfg=Yellow
    hi link CmpItemKindProperty CmpItemKindField
    hi link CmpItemKindEvent CmpItemKindField
    hi link CmpItemKindEnumMember CmpItemKindField
hi CmpItemKindText ctermfg=White
hi CmpItemKindKeyword ctermfg=Red
    hi link CmpItemKindConstructor CmpItemKindKeyword
    hi link CmpItemKindReference CmpItemKindKeyword
hi CmpItemKindValue ctermfg=DarkGreen
hi CmpItemKindFunction ctermfg=DarkMagenta
    hi link CmpItemKindMethod CmpItemKindFunction
    hi link CmpItemKindStruct CmpItemKindFunction
    hi link CmpItemKindClass CmpItemKindFunction
    hi link CmpItemKindOperator CmpItemKindFunction
    hi link CmpItemKindEnum CmpItemKindFunction
hi CmpItemKindModule ctermfg=DarkGreen
hi CmpItemKindVariable ctermfg=DarkBlue
    hi link CmpItemKindConstant CmpItemKindVariable
    hi link CmpItemKindFile CmpItemKindVariable
hi CmpItemKindFolder ctermfg=DarkCyan
hi CmpItemKindInterface ctermfg=DarkCyan
    hi link CmpItemKindTypeParameter CmpItemKindInterface

hi link @lsp.type.lifetime.rust Statement
hi link @lsp.type.keyword.rust Statement

hi @lsp.mod.readonly ctermbg=NONE ctermfg=DarkRed

hi link @function.make Normal
hi link @function.call.bash Normal

hi @text.reference ctermbg=NONE ctermfg=DarkCyan
hi @text.literal ctermfg=Green

hi link TelescopeBorder FloatBorder

hi IlluminatedWordText ctermbg=LightGray
hi link IlluminatedWordRead  IlluminatedWordText
hi link IlluminatedWordWrite IlluminatedWordText

hi link LspInfoBorder FloatBorder

" mason
hi MasonHeader ctermbg=DarkMagenta ctermfg=White cterm=bold
hi MasonHeaderSecondary ctermbg=DarkRed ctermfg=White

hi MasonHighlight ctermfg=DarkCyan
hi MasonHighlightBlock ctermbg=DarkCyan ctermfg=Black
hi MasonHighlightBlockBold ctermbg=DarkCyan ctermfg=Black cterm=bold

hi MasonHighlightSecondary ctermfg=DarkYellow
hi MasonHighlightSecondaryBlock ctermbg=DarkYellow ctermfg=Black
hi MasonHighlightSecondaryBlockBold ctermbg=DarkYellow ctermfg=Black cterm=bold

" indent-blankline
" :h ibl.highlights
hi IblIndent ctermfg=7 ctermbg=NONE
    hi link IblWhitespace      IblIndent
    hi link @ibl.indent.char.1 IblIndent

" Markdown (via treesitter)
hi link @markup.list Delimiter
hi link @markup.heading Title

" }}}

" Plugin options {{{

let g:limelight_conceal_ctermfg = 8

" }}}
