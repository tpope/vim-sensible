" sensible.vim - Defaults everyone can agree on
" Maintainer:   Tim Pope <http://tpo.pe/>

if exists('g:loaded_sensible') || &compatible
  finish
endif
let g:loaded_sensible = 1

filetype plugin indent on
if !exists('g:syntax_on')
  syntax enable
endif

set backspace=indent,eol,start
set complete-=i
set showmatch

set autoindent
set smarttab

set ttimeout
set ttimeoutlen=50

set incsearch
set smartcase

set laststatus=2
set ruler
set showcmd
set wildmenu

set scrolloff=1
set sidescrolloff=5
set display+=lastline

if !&list && &listchars ==# 'eol:$'
  set list
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
  if &termencoding ==# 'utf-8' || &encoding ==# 'utf-8'
    let &listchars = "tab:\u21e5 ,trail:\u2423,extends:\u21c9,precedes:\u21c7,nbsp:\u26ad"
    let &fillchars = "vert:\u259a,fold:\u00b7"
  endif
endif

set autoread
set fileformats=unix,dos,mac

set viminfo+=!

if exists('+undofile')
  set undofile
endif

nnoremap Y y$

" vim:set ft=vim et sw=2:
