set nocompatible              " be iMproved
filetype off                  " required for Vundle.

" Set the runtime path to include Vundle and initialize.
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage Vundle, required.
Plugin 'VundleVim/Vundle.vim'

Plugin 'scrooloose/syntastic'
Plugin 'rust-lang/rust.vim'
Plugin 'racer-rust/vim-racer'
Plugin 'cespare/vim-toml'
Plugin 'nvie/vim-flake8'
Plugin 'raichoo/smt-vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

syntax on
set hidden

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
" Wrap coments at 79
set textwidth=79
" Ignore modelines in source files. Moz sources set tw=99 which then breaks
" comment reflow.
set nomodeline

" Always display a status line.
set laststatus=2
" Display line and column.
set ruler
set statusline=%n\ %f%M%R%=%y%15(L%l,%c%V%)/%L
" Don't beep.
set visualbell
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

" By default, Q enters Ex-mode which is annoying. Use it for reformatting.
map Q gq
" Don't indent to second line.
set formatoptions-=2
" Don't wrap lines that were already too long.
set formatoptions+=l
" Recognize number lists.
set formatoptions+=n
" Remove comment leader when joining lines.
set formatoptions+=j
set formatlistpat=^\\s*\\d\\+\\.\\s\\+\\\|^[-*+]\\s\\+
set autoindent

" Switch compilers for Rust code.
autocmd BufRead,BufNewFile Cargo.toml,Cargo.lock,*.rs compiler cargo
"let g:rustfmt_autosave=1
let g:rustfmt_fail_silently=1
set errorformat+=\%f:%l:%c:\ %t%*[^:]:\ %m
set errorformat+=\%f:%l:%c:\ %*\\d:%*\\d\ %t%*[^:]:\ %m
let $RUST_SRC_PATH = $HOME . '/.multirust/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src'

" Syntastic.
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_python_exec = "/usr/local/bin/python3"
let g:syntastic_python_pylint_args = "--py3k"
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_rst_checkers = []

" Syntastic C++ code is currently gecko.
let g:syntastic_cpp_include_dirs = [ $HOME . '/gecko-dev/obj-x64dev/dist/include', $HOME . '/gecko-dev/obj-x64dev/js/src' ]
let g:syntastic_cpp_compiler_options = '-std=gnu++11 -DDEBUG=1 -DJS_CODEGEN_X64 -Wno-invalid-offsetof'

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

" Set up spell checking.
set spellcapcheck=[.?][\ \t]\+
set spell

" The trailing semicolon makes the tag search go up the hierarchy.
set tags=./tags,tags;
