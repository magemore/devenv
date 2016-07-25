

set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
set background=dark

set t_Co=256            " use 256 colors in vim
"colorscheme desert256   " an appropriate color scheme
"colorscheme luna

set autoread

"set swapfile
"set dir=~/tmp


set viminfo='20,<1000,s1000
set mouse=a
set clipboard=unnamedplus
"nnoremap / _i//<ESC>gj_
"nnoremap <c-q> <ESC>:w!<ENTER><ESC>:q!<ENTER>
"inoremap <c-q> <ESC>:w!<ENTER><ESC>:q!<ENTER>
"nnoremap <c-q> <ESC>:q<ENTER>
"inoremap <c-q> <ESC>:q<ENTER>
"nnoremap <c-e> <ESC>:q!<ENTER>
"inoremap <c-e> <ESC>:q!<ENTER>
"nnoremap <c-w> <ESC>:w!<ENTER>
"inoremap <c-w> <ESC>:w!<ENTER>
"map <ESC> <ESC>:w!<ENTER>
noremap <F1> <ESC>:w!<ENTER><ESC>:r! git_vim_commit<ENTER>dd<ESC>
inoremap <F1> <ESC>:w!<ENTER><ESC>:r! git_vim_commit<ENTER>dd<ESC>
noremap <F2> <ESC>:wq!<ENTER><ESC>
inoremap <F2> <ESC>:wq!<ENTER><ESC>
noremap <F3> <ESC>:r! ext_edit '%:p'<ENTER>dd<ESC>
inoremap <F3> <ESC>:r! ext_edit '%:p'<ENTER>dd<ESC>
noremap <F4> <ENTER>:q!<ENTER><ESC>
inoremap <F4> <ENTER>:q!<ENTER><ESC>
noremap <F5> <ESC>:set mouse=a<ENTER><ESC>
inoremap <F5> <ESC>:set mouse=a<ENTER><ESC>
noremap <F6> <ESC>:set mouse=<ENTER><ESC>
inoremap <F6> <ESC>:set mouse=<ENTER><ESC>

"inoremap <c-1> <ESC>:q!<ENTER>
"inoremap <c-1> <ESC>:q!<ENTER>
"map <c-a> <ESC>:q!<ENTER>
"map <c-w> <ESC>:w!<ENTER>
"noremap <c-r> <ESC>:edit!<ENTER>

"nnoremap <c-t> <ESC>:r! date<ENTER>

"vnoremap <c-d> <ESC>/(<ENTER>bv/(<ENTER>d<ESC>i
"nnoremap <c-d> <ESC>/(<ENTER>bv/(<ENTER>d<ESC>i
"inoremap <c-d> <ESC>/(<ENTER>bv/(<ENTER>d<ESC>i

"noremap <c-c> <ESC>Vy
"noremap <c-v> <ESC>p
noremap <F7> <esc>:r! cat /tmp/share<ENTER><esc>j-i

" noremap y y
" todo later maybe

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
