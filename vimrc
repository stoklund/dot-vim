set nocompatible              " be iMproved
filetype off                  " required for Vundle.

" Set the runtime path to include Vundle and initialize.
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage Vundle, required.
Plugin 'VundleVim/Vundle.vim'

Plugin 'altercation/vim-colors-solarized'
Plugin 'Valloric/YouCompleteMe'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

syntax on
let g:ycm_extra_conf_globlist = ['~/gecko-dev/*']

" By default, Q enters Ex-mode which is annoying. Use it for reformatting.
map Q gq

map <C-]> :YcmCompleter GoTo<cr>

" Hook up clang-format to C-K.
map <C-K> :pyf /usr/local/share/clang/clang-format.py<cr>
imap <C-K> <c-o>:pyf /usr/local/share/clang/clang-format.py<cr>

" Don't indent inside C++ namespaces.
" : Indent case labels by half the shiftwidth.
" = Indent statements after cases by half a shiftwidth reletive to the case.
" g C++ public/private indent.
" h After public/private indent.
" N Additional namespace indent. (Cancels ns indentation).
set cinoptions=N-s,:0.5s,=0.5s,g0.5s,h0.5s
" Default shiftwidth.
set shiftwidth=4
" Highlight col 99 for mozilla sources
set colorcolumn=99
" Wrap coments at 80
set textwidth=80

" Always display a status line.
set laststatus=2
" Display line and column.
set ruler
" Don't beep
set novisualbell
" Automaticaly save when switching buffers.
set autowriteall

" Configure Solarized.
let g:solarized_termcolors=256
let g:solarized_hitrail=1    "default value is 0
syntax enable
set background=dark
colorscheme solarized

set guifont=Menlo:h13
" No scroll bars.
set guioptions-=r
set guioptions-=L

set ignorecase
set smartcase
set autowrite
set expandtab
" Don't let J and Q use double space after sentences.
set nojoinspaces
