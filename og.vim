" Colorscheme
highlight Visual guibg=#2b2f36

" Vim Tex
let g:vimtex_view_method = 'zathura'
let g:vimtex_compiler_method = 'latexrun'

" Local Leader key
let maplocalleader = "\\"


" C helpers

" Global indentation settings - force after plugins load
augroup ForceIndent
    autocmd!
    autocmd VimEnter * set tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab
    autocmd BufRead,BufNewFile,BufEnter * setlocal tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab
augroup END

" switch between .h and .c
au BufEnter,BufNew *.c nnoremap <silent> ;p :e %<.h<CR>
au BufEnter,BufNew *.h nnoremap <silent> ;p :e %<.c<CR>

" Force tab settings on buffer enter for C files
au BufEnter *.c,*.h setlocal tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab
au BufWinEnter *.c,*.h setlocal tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab

" Quick mapping to fix indentation
nnoremap <silent> ;t :setlocal tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab<CR>

au BufEnter,BufNew *.c nnoremap <silent> ;vp :leftabove vs %<.h<CR>
au BufEnter,BufNew *.h nnoremap <silent> ;vp :rightbelow vs %<.c<CR>

au BufEnter,BufNew *.c nnoremap <silent> ;hp :leftabove split %<.h<CR>
au BufEnter,BufNew *.h nnoremap <silent> ;hp :rightbelow split %<.c<CR>

" open same file in vertical/horizonal splits
nnoremap <silent> ;hs :leftabove vsplit %<CR>
nnoremap <silent> ;vs :leftabove split %<CR>

" Set the number of spaces a tab counts for
set tabstop=4
set shiftwidth=4
set softtabstop=4
" Use actual tab characters, not spaces
set noexpandtab

" Filetype
filetype plugin indent on

" Syntax
syntax enable

" Wrap
set wrap

" Cases
set ignorecase
set smartcase

" nnoremap <leader>m :wincmd w<CR>

" Map Spectre
" nnoremap rr :lua require('spectre').open()<CR>
" nnoremap rw :lua require('spectre').open_file_search()<CR>

" Get syntax files
set runtimepath+=~/.config/nvim/syntax

" Disable C-z and enable number toggle
nnoremap <c-z> <nop>

if(!has("nvim"))
    nnoremap <F3> :NumbersToggle<CR>
    nnoremap <F4> :NumbersOnOff<CR>
endif

" default file encoding
set encoding=utf-8

" Map F8 to Tagbar
nmap <F8> :TagbarToggle<CR>

" Map (S-)Tab to >.<
vmap <Tab> >gv
vmap <S-Tab> <gv
