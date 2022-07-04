let mapleader = ","

" ================================+
" PLUGINS
" ================================-

call plug#begin('~/.config/nvim/plugged')

" =================================
" vim-surround
" add/change/delete surrounding characters
" > Use ys<motion><mapping> to surround with things like quotes, parens, etc.
" > Use <visual>S<mapping> to surround visually selected area
" =================================
Plug 'tpope/vim-surround'

" =================================
" vim-rooter
" changes directory to project root
" =================================
Plug 'airblade/vim-rooter'

" =================================
" nerdcommenter
" commenting shortcuts
" =================================
Plug 'scrooloose/nerdcommenter'
let g:NERDSpaceDelims = 1             " add spaces after comment marker
let g:NERDDefaultAlign = 'left'       " align comment markers flush against the left border
let g:NERDCreateDefaultMappings = 0
let g:NERDCustomDelimiters = { 'pug': { 'left': '//' } }

" =================================
" vim-fugitive
" even awesomer git/vim integration
" =================================
Plug 'tpope/vim-fugitive'

" vim-fugitive
nnoremap <leader>gb :Git blame<cr>

" =================================
" gitgutter
" =================================
Plug 'airblade/vim-gitgutter'

let g:gitgutter_map_keys = 0
nnoremap <leader>ggu :GitGutterUndoHunk<cr>
nnoremap <leader>ggp :GitGutterPreviewHunk<cr>
nnoremap <leader>ggs :GitGutterStageHunk<cr>
nnoremap <leader>ggc :pclose<cr>
nnoremap <leader>ggq <silent> :GitGutterQuickFixCurrentFile<cr>:cw<cr>
nnoremap <space>j <Plug>(GitGutterNextHunk)
nnoremap <space>k <Plug>(GitGutterPrevHunk)

" =================================
" tagbar
" nice tag support/functionality
" =================================
Plug 'majutsushi/tagbar'

" Move to the TagBar if already opened or open and focus
" close the TagBar after selection
nnoremap <leader>tbo :TagbarOpen fj<cr>
nnoremap <leader>tbc :TagbarClose<cr>

let g:tagbar_type_markdown = {
    \ 'ctagstype': 'markdown',
    \ 'kinds': [
        \ 'h:Heading_L1',
        \ 'i:Heading_L2',
        \ 'k:Heading_L3'
    \ ]
\ }

" =================================
" matchit
" %-matching with more than just characters
" =================================
Plug 'tmhedberg/matchit'

" =================================
" lightline
" lightweight version of airline
" =================================
Plug 'itchyny/lightline.vim'

let g:lightline = {
    \ 'colorscheme': 'wal',
    \ 'active': {
    \   'right': [ [ 'lineinfo' ],
    \               [ 'percent'  ],
    \               [ 'filetype' ] ] },
    \ 'inactive': {
    \   'left': [ [ 'filename', 'modified' ] ] }
    \ }

" =================================
" setcolors
" =================================
Plug 'felixhummel/setcolors.vim'

" =================================
" tabularize
" lining up things in margins
" =================================
Plug 'godlygeek/tabular'

" Tabularize on pipes
function! s:align()
    let p = '^\s*|\s.*\s|\s*$'
    if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
        let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
        let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
        Tabularize/|/l1
        normal! 0
        call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
    endif
endfunction

" =================================
" rainbow parens
" =================================
Plug 'kien/rainbow_parentheses.vim'

" =================================
" vim-jinja
" =================================
Plug 'mitsuhiko/vim-jinja', { 'for': ['jinja'] }

" =================================
" vim-javascript
" =================================
Plug 'pangloss/vim-javascript', { 'for': ['javascript'] }

" =================================
" vim-jsx
" =================================
Plug 'amadeus/vim-jsx', { 'for': ['jsx'] }

" =================================
" vim-yaml
" =================================
Plug 'stephpy/vim-yaml', { 'for': ['yaml'] }

" =================================
" emmet-vim
" =================================
Plug 'mattn/emmet-vim', { 'for': ['html', 'css'] }

" =================================
" vim-scala
" =================================
Plug 'derekwyatt/vim-scala', { 'for': ['scala'] }

" =================================
" SQLUtilities
" =================================
Plug 'vim-scripts/SQLUtilities', { 'for': ['sql'] }

" =================================
" terraform
" =================================
Plug 'hashivim/vim-hashicorp-tools', { 'for': ['terraform'] }

" =================================
" rust.vim
" file detection, syntax highlighting, formatting, syntastic integration (if
" installed), tagbar integration, other minor things...
" =================================
Plug 'rust-lang/rust.vim', { 'for': ['rust'] }

" recover jump forwards motion after mapping Tab (which == <C-i>)
nnoremap <C-h> <C-i>

" =================================
" vim-indent-guides
" visual cues for indentation level
" =================================
Plug 'Yggdroot/indentLine'

" =================================
" vim-json
" json ftplugin for better controls
" =================================
Plug 'elzr/vim-json', { 'for': ['json'] }
" don't conceal json quotes, etc.
let g:vim_json_syntax_conceal=0

" =================================
" vim-markdown
" markdown ftplugin for better controls
" =================================
Plug 'tpope/vim-markdown', { 'for': ['markdown'] }
" specific syntax highlighting within code blocks
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']
" don't conceal markdown formatting
let g:markdown_syntax_conceal = 0

" =================================
" vim-jsonnet
" jsonnet ftplugin for better controls
" =================================
Plug 'google/vim-jsonnet', { 'for': ['jsonnet'] }

" =================================
" fzf
" ctrl-p for searching files, etc.
" =================================
Plug 'junegunn/fzf'

" =================================
" nvim-lspconfig
" LSP client config
" =================================
Plug 'neovim/nvim-lspconfig'

" =================================
" nvim-cmp
" Lua-based autocompletion
" =================================
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

call plug#end()

set completeopt=menu,menuone,noselect

lua << EOF
    -- Mappings.
    -- See `:help vim.diagnostic.*` for documentation on any of the below functions
    local opts = { noremap=true, silent=true }
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '<c-k>', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', '<c-j>', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

    -- Set "<" prefix before diagnostic virtual text
    vim.diagnostic.config({
      virtual_text = {prefix = '<'},
    })

    -- Use an on_attach function to only map the following keys
    -- after the language server attaches to the current buffer
    local on_attach = function(client, bufnr)
      -- Enable completion triggered by <c-x><c-o>
      vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

      -- Mappings.
      -- See `:help vim.lsp.*` for documentation on any of the below functions
      local bufopts = { noremap=true, silent=true, buffer=bufnr }
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
      vim.keymap.set('n', 'gc', vim.lsp.buf.incoming_calls, bufopts)
      vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, bufopts)
      vim.keymap.set('n', '<space>d', vim.lsp.buf.type_definition, bufopts)
	  vim.keymap.set('n', '<space>K', vim.lsp.buf.signature_help, bufopts)
      vim.keymap.set('i', '<c-k>', vim.lsp.buf.signature_help, bufopts)
      vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
      vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
    end

    local lsp_flags = {
      -- This is the default in Nvim 0.7+
      debounce_text_changes = 150,
    }

    -- nvim-cmp configuration
    local cmp = require'cmp'

    cmp.setup({
      snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
          vim.fn["vsnip#anonymous"](args.body)
        end,
      },
      window = {},
      mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      }),
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' },
      }, {
        { name = 'buffer' },
      })
    })

    -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline('/', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' }
      }
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' }
      }, {
        { name = 'cmdline' }
      })
    })

    -- Setup lspconfig.
    local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

    require('lspconfig')['gopls'].setup {
        on_attach = on_attach,
        flags = lsp_flags,
        capabilities = capabilities
    }

    require('lspconfig')['rust_analyzer'].setup {
        on_attach = on_attach,
        flags = lsp_flags,
        capabilities = capabilities
    }
EOF

filetype plugin indent on
syntax enable

" =================================
" Options and variables
" =================================

set background=dark
colo wal

" Update gitgutter or anything using CursorHold autocommand event quicker
set updatetime=100

" Always show 2 columns for signs (gitgutter & lsp)
set signcolumn=yes:2

" Turn on the Wild menu
set wildmenu

" Better tab completion for wildmenu
set wildmode=longest,list,full

" Ignore compiled files
set wildignore=*.o,*~,*.pyc,*/tmp/*,*.zip

" Always show current position
set ruler

" When searching try to be smart about cases
set ignorecase
set smartcase

" Highlight search results
set hlsearch

" Find words as typing out search
set incsearch

if has('nvim')
    " Show the results of a substitution while you type (but not in a split window
    set inccommand=nosplit
endif

" Break at reasonable character (see 'breakat') for wrapped lines
set linebreak
" Indent wrapped lines accordingly
set breakindent
" Set characters to designate the continued lines
set showbreak=\ \ \\\  " this comment only exists so this value's trailing space doesn't get deleted by an autocmd below

" Start scrolling before cursor hits top/bottom
set scrolloff=3

" Show relative line numbers
set relativenumber
" But still show current line number
set number

" Number of lines to jump when scrolling off screen
" -# = percentage
" set scrolljump=-30

" When splitting windows, keep what you're working on in the main position
set splitbelow
set splitright

" Use ripgrep if ya got it!
if executable("rg")
    set grepprg=rg\ --vimgrep
    set grepformat^=%f:%l:%c:%m
    " Recursively search for word under cursor
    nnoremap <leader>f :silent grep <C-R><C-W><CR>:cw<CR>
    " Recursively search for visually selected phrase
    vnoremap <leader>f y:silent grep '<C-R>"'<CR>:cw<CR>
endif

set pastetoggle=<F11>

" Quick funtion that will highlight over 80 columns on cpp files
autocmd FileType cpp :autocmd! BufWritePre * :match ErrorMsg '\%>80v.\+'

" Set keywordprg according to filetype
autocmd FileType vim :setlocal keywordprg=:help
autocmd FileType yaml :setlocal keywordprg=:DevDocs

" Disable expensive and broken markdown code block highlighting
autocmd syntax markdown syntax clear markdownCodeBlock

" Set textwidth to 80 for markdown
autocmd FileType markdown :setlocal textwidth=80

" Set textwidth to 100 for python
autocmd FileType python :setlocal textwidth=100

" Use Unix as the standard file type
set ffs=unix,mac,dos

" setup tags
set tags=./.tags;/

" Turn backup off, since most stuff is in SVN, git etc.
set nobackup
set nowb
set noswapfile

" Use spaces instead of tabs
set expandtab

" Do not expand tab for Makefiles
autocmd FileType make set noexpandtab

" Be smart when using tabs
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4
set softtabstop=4

" Auto indent and wrap lines
set autoindent
set wrap

" Create folds based on indentation
set foldmethod=indent
" Only fold up to a max of two times
set foldnestmax=2
" Start with all folds open
set foldlevel=99

set previewheight=999

" 'Add/substract' letters with ctrl-a / ctrl-x
set nrformats+=alpha

" Allow backspacing over autoindent, line breaks, and start of insert
set backspace=indent,eol,start

" Set persistent undo and undodir
set undodir=~/.config/nvim/undodir
set undofile

set rtp+=/usr/local/opt/fzf

" Auto remove trailing whitespace on write
autocmd BufWritePre * :%s/\s\+$//e

autocmd BufWritePre *.go lua vim.lsp.buf.formatting_sync()

" Split help window on longer axis
function! Fit_help(...)
    if winwidth('%') > winheight('%')
        execute "vert help " . join(a:000, ' ')
    else
        execute "help " . join(a:000, ' ')
    endif
endfunction
command! -nargs=* -complete=help H call Fit_help(<f-args>)

" Split file(s) across larger current dimension
function! s:auto_split(...)
    if winwidth(0) > winheight(0) * 2.5
        execute "vert split " . join(a:000, ' ')
    else
        execute "split " . join(a:000, ' ')
    endif
endfunction
command! -nargs=* -complete=file Asp call s:auto_split(<f-args>)
nnoremap <leader>asp :Asp<space>

" Operator maps to get inside () '' // and "
onoremap in( :<c-u>normal! f(vi(<cr>
onoremap in) :<c-u>normal! F)vi)<cr>
onoremap in{ :<c-u>normal! f{vi{<cr>
onoremap in} :<c-u>normal! F}vi}<cr>
onoremap in[ :<c-u>normal! f[vi[<cr>
onoremap in] :<c-u>normal! F]vi]<cr>
onoremap in' :<c-u>normal! f'vi'<cr>
onoremap il' :<c-u>normal! F'vi'<cr>
onoremap in" :<c-u>normal! f"vi"<cr>
onoremap il" :<c-u>normal! F"vi"<cr>
onoremap il" :<c-u>normal! F"vi"<cr>
onoremap i/ :<c-u>normal! T/vt/<cr>
onoremap <space> t_
onoremap i<space> :<c-u>normal! T_vt_<cr>
onoremap a<space> :<c-u>normal! F_vf_<cr>

" Indent conveniences with Tab
vnoremap > >gv
vnoremap < <gv
nnoremap <Tab> >>_
nnoremap <S-Tab> <<_
inoremap <S-Tab> <C-D>
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" Set the paste toggle
map <F10> :set paste<cr>
map <F11> :set nopaste<cr>
imap <F10> <C-O>:set paste<CR>
imap <F11> <nop>

" Move to next or previous buffer
nnoremap <leader>[ :bp<cr>
nnoremap <leader>] :bn<cr>
nnoremap <leader>b <C-^>

" Increase and Decrease the width of a vertically split window
nnoremap <leader>< :vertical resize -10<cr>
nnoremap <leader>> :vertical resize +10<cr>

" Like gf but split window
nnoremap gs :wincmd f<cr>
nnoremap gS :vertical wincmd f<cr>

" Source and Edit nvim/init
nnoremap <leader>src :source ~/.config/nvim/init.vim<cr>
nnoremap <leader>erc :Asp ~/.config/nvim/init.vim<cr>

" Sudo save a file
nnoremap <leader>save :w !sudo dd of=%<cr>

nnoremap <leader>PI :PlugInstall<cr>
nnoremap <leader>PU :PlugUpdate<cr>
nnoremap <leader>PC :PlugClean<cr>

" Backspace alternates buffers
nnoremap <BS> <C-^>

" use ctrl-p as shortcut for :FZF
nnoremap <C-p> :FZF --layout=reverse<cr>

" Execute @q easily
nnoremap Q @q

" Use backtick over single quotes for jumping
nnoremap ' `

nnoremap <leader>mks :mksession!<cr>

" Remove current highlighting
nnoremap <silent> <leader>/ :noh<cr>

" Search and replace
nnoremap <leader>sar :%s/<C-R><C-W>//gc<left><left><left>
vnoremap <leader>sar "sy:%s/\<<C-R>s\>//gc<left><left><left>

" Resize pane to its height
nnoremap <leader>ww :execute "resize " . line('$')<cr>gg

nnoremap <leader>pass :let @p = system('openssl rand -base64 16 \| head -c 20')<cr>:echo @p<cr>

nnoremap <leader>term :tabnew +term<cr>

inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

" base64 decoding and encoding
vnoremap <leader>64d c<c-r>=system('base64 --decode', @")<cr><esc>
vnoremap <leader>64e c<c-r>=system('base64', @")<cr><esc>

nnoremap <leader>c<space> <Plug>NERDCommenterToggle
vnoremap <leader>c<space> <Plug>NERDCommenterToggle

" Make <ESC> exit terminal insert mode
if has('nvim')
    tnoremap <Esc> <C-\><C-n>
endif

function! SynGroup()
    let l:s = synID(line('.'), col('.'), 1)
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun

function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

nnoremap <leader>hi :call SynGroup()<CR>

" Mark position before going to top or bottom of file for easy returns
nnoremap gg mjgg
nnoremap G mkG

" Use <Up> and <Down> for location list, <C-j> and <C-k> for quickfix list
nnoremap <Up> :cp<cr>
nnoremap <Down> :cn<cr>
