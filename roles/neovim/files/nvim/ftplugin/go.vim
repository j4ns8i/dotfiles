set hidden

let b:ale_linters = ['gofmt', 'gopls']
let b:ale_fixers = ['gofmt', 'goimports']
let g:ale_virtualtext_cursor = 1

set noexpandtab

" move through quickfix list easily
nnoremap <leader>} :cne<cr>
nnoremap <leader>{ :cp<cr>

call deoplete#custom#option('sources', {
            \ 'go': ['ale'],
            \})
