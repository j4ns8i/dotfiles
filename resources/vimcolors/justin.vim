" vim: et sw=2 sts=2

highlight clear

if exists('syntax_on')
  syntax reset
endif

"   BLACK     0   8
"   RED       1   9
"   GREEN     2   10
"   YELLOW    3   11
"   BLUE      4   12
"   MAGENTA   5   13
"   CYAN      6   14
"   WHITE     7   15

highlight   Normal       ctermfg=Gray
highlight   Comment      ctermfg=DarkGray
highlight   Statement    ctermfg=DarkRed
highlight   Type         ctermfg=Green
highlight   Constant     ctermfg=Blue
highlight   PreProc      ctermfg=Yellow
highlight   Identifier   ctermfg=Yellow      cterm=bold
highlight   Special      ctermfg=Red
highlight   Todo         ctermfg=Magenta
highlight   Error        ctermfg=Black       ctermbg=Magenta
highlight   Search       ctermbg=DarkGreen   ctermfg=Black
highlight   Directory    ctermfg=Cyan

" Markdown
highlight Title ctermfg=Magenta cterm=bold
highlight Underlined ctermfg=Magenta cterm=bold

let g:colors_name = 'justin'
