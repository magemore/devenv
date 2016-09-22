

set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab
"set background=dark

set t_Co=256            " use 256 colors in vim
"colorscheme desert256   " an appropriate color scheme
"colorscheme luna
"colorscheme highwayman
"colorscheme spurs_away
colorscheme gotham256


set autoread

"set swapfile
"set dir=~/tmp


set viminfo='20,<1000,s1000
set mouse=
set clipboard=unnamedplus

nnoremap <F1> <ESC>:w!<ENTER>
inoremap <F1> <ESC>:w!<ENTER>

nnoremap <F2> <ESC>:wq!<ENTER><ESC>
inoremap <F2> <ESC>:wq!<ENTER><ESC>

nnoremap <F3> <ESC>:r! ext_edit '%:p'<ENTER>dd<ESC>:q!<ENTER>
inoremap <F3> <ESC>:r! ext_edit '%:p'<ENTER>dd<ESC>:q!<ENTER>

nnoremap <F4> <ESC>:q!<ENTER>
inoremap <F4> <ESC>:q!<ENTER>


"toggle mouse with F7, F6
nnoremap <F5> <ESC>:set mouse=a<ENTER><ESC>
inoremap <F5> <ESC>:set mouse=a<ENTER><ESC>

nnoremap <F6> <ESC>:set mouse=<ENTER><ESC>
inoremap <F6> <ESC>:set mouse=<ENTER><ESC>

noremap <F7> <esc>:r! cat /tmp/share<ENTER><esc>j-i


"bar with tags, list of functions and variables
nmap <F8> :TagbarToggle<CR>

nnoremap <F9> <ESC>V:w! /tmp/buff.txt<ENTER>
inoremap <F9> <ESC>V:w! /tmp/buff.txt<ENTER>

nnoremap <Tab> <c-w>w
nnoremap <bs> <c-w>W


" todo: find out how from vim script check file format
" todo: play with vim plugins make something like watch built in and try to edit several files at once in vim.
" maybe enable mouse... but after enabling mouse can't pase with middle key. maybe middle rewrite somehow on linux level

" todo: make clipboard buffer over web interface
" imap <c-n> <CR><CR><C-o>k<Tab>







" todo: add buffer read from http://share.io/data/share
" c-c will copy from share and c-v will paste from share. fucking amazing

" most importent make vim clipboard work. but i cant now. time 10min

"vmap <C-c> "*y     " Yank current selection into system clipboard
"nmap <C-c> "*Y     " Yank current line into system clipboard (if nothing is selected)
"nmap <C-v> "*p     " Paste from system clipboard

if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

set nobackup
set nowrap
"set matchtime=2
"set number

execute pathogen#infect()

filetype plugin indent on

set complete+=k~/.vim/dict/php.dict

call plug#begin('~/.vim/plugged')

Plug 'whatyouhide/vim-gotham'

call plug#end()

set statusline+=%F
set laststatus=2


set backupdir-=.
set backupdir^=~/tmp,/tmp
set nobackup
