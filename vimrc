set nocompatible              " be iMproved
filetype off                  " required for Vundle.

" Set the runtime path to include Vundle and initialize.
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage Vundle, required.
Plugin 'VundleVim/Vundle.vim'

Plugin 'Valloric/YouCompleteMe'
Plugin 'rust-lang/rust.vim'
Plugin 'cespare/vim-toml'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

syntax on
let g:ycm_extra_conf_globlist = ['~/gecko-dev/*']
let g:ycm_rust_src_path = '~/rust'

" By default, Q enters Ex-mode which is annoying. Use it for reformatting.
map Q gq

map <C-]> :YcmCompleter GoTo<cr>

" Hook up clang-format to C-K.
map <C-K> :pyf /usr/local/share/clang/clang-format.py<cr>
imap <C-K> <c-o>:pyf /usr/local/share/clang/clang-format.py<cr>

" Don't indent inside C++ namespaces.
" : Indent case labels by half the shiftwidth.
" = Indent statements after cases by half a shiftwidth relative to the case.
" g C++ public/private indent.
" h After public/private indent.
" N Additional namespace indent. (Cancels ns indentation).
set cinoptions=N-s,:0.5s,=0.5s,l1,g0.5s,h0.5s,(0
" Default shiftwidth.
set shiftwidth=4
" Highlight col 99 for Mozilla sources.
set colorcolumn=99
" Wrap coments at 80
set textwidth=80
" Ignore modelines in source files. Moz sources set tw=99 which then breaks
" comment reflow.
set nomodeline

" Always display a status line.
set laststatus=2
" Display line and column.
set ruler
" Don't beep
set novisualbell
" Automaticaly save when switching buffers.
set autowriteall

" Syntax highlighting, colorscheme.
syntax enable
set background=dark
colorscheme twilight

" Configure GUI.
set linespace=2
set guifont=Menlo:h14
" No scroll bars.
set guioptions-=r
set guioptions-=L

set ignorecase
set smartcase
set autowrite
set expandtab
" Don't let J and Q use double space after sentences.
set nojoinspaces

" Switch compilers.
autocmd BufRead,BufNewFile Cargo.toml,Cargo.lock,*.rs compiler cargo
let g:rustfmt_autosave=1
set errorformat+=\%f:%l:%c:\ %t%*[^:]:\ %m
set errorformat+=\%f:%l:%c:\ %*\\d:%*\\d\ %t%*[^:]:\ %m

" Hook up git grep to :G.
func GitGrep(...)
  let save = &grepprg
  set grepprg=git\ grep\ -n\ $*
  let s = 'grep'
  for i in a:000
    let s = s . ' ' . i
  endfor
  exe s
  let &grepprg = save
endfun
command -nargs=? G call GitGrep(<f-args>)
