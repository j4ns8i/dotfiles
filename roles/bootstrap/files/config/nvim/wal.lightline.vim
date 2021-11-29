" =============================================================================
" Filename: autoload/lightline/colorscheme/wal.vim
" Author: atweiden,jsmalkowski
" License: MIT License
" Last Change: 2015/11/02 08:23:27.
" =============================================================================
let s:base03 = [ '#151513', 233 ]
let s:black = [ '#30302c ', 0 ]
let s:darkgray = [ '#4e4e43', 237 ]
let s:base00 = [ '#666656', 242  ]
let s:base0 = [ '#808070', 8 ]
let s:base1 = [ '#949484', 246 ]
let s:base2 = [ '#a8a897', 248 ]
let s:base3 = [ '#e8e8d3', 253 ]
let s:peach = [ '#d7afaf', 181 ]
let s:orange = [ '#d7875f', 216 ]

let  s:black         =  [  '#000000',  0   ]
let  s:red           =  [  '#d68787',  1   ]
let  s:green         =  [  '#87af87',  2   ]
let  s:yellow        =  [  '#d8af5f',  3   ]
let  s:blue          =  [  '#87afaf',  4   ]
let  s:magenta       =  [  '#df5f87',  5   ]
let  s:cyan          =  [  '#87d7d7',  6   ]
let  s:white         =  [  '#d0d0d0',  7   ]
let  s:lightblack    =  [  '#363636',  8   ]
let  s:lightred      =  [  '#d68787',  9   ]
let  s:lightgreen    =  [  '#87af87',  10  ]
let  s:lightyellow   =  [  '#d8af5f',  11  ]
let  s:lightblue     =  [  '#87afaf',  12  ]
let  s:lightmagenta  =  [  '#df5f87',  13  ]
let  s:lightcyan     =  [  '#87d7d7',  14  ]
let  s:lightwhite    =  [  '#d0d0d0',  15  ]

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}
let s:p.normal.left = [ [ s:black, s:blue ], [ s:white, s:lightblack ] ]
let s:p.normal.right = [ [ s:lightwhite, s:lightblack ], [ s:white, s:lightblack ] ]
let s:p.insert.left = [ [ s:black, s:green ], [ s:white, s:lightblack ] ]
let s:p.replace.left = [ [ s:black, s:magenta ], [ s:white, s:lightblack ] ]
let s:p.visual.left = [ [ s:black, s:yellow ], [ s:white, s:lightblack ] ]
let s:p.normal.middle = [ [ s:white, s:lightblack ] ]
let s:p.inactive.middle = [ [ s:black, s:lightblack ] ]
let s:p.inactive.right = [ [ s:black, s:lightblack ], [ s:black, s:lightblack ] ]
let s:p.inactive.left =  [ [ s:black, s:lightblack ], [ s:black, s:lightblack ] ]
let s:p.tabline.left = [ [ s:base3, s:base00 ] ]
let s:p.tabline.tabsel = [ [ s:base3, s:black ] ]
let s:p.tabline.middle = [ [ s:black, s:base1 ] ]
let s:p.tabline.right = copy(s:p.normal.right)
let s:p.normal.error = [ [ s:red, s:black ] ]
let s:p.normal.warning = [ [ s:yellow, s:red ] ]

let g:lightline#colorscheme#wal#palette = lightline#colorscheme#flatten(s:p)
