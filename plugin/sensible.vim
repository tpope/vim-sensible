" sensible.vim - Defaults everyone can agree on
" Maintainer:   Tim Pope <http://tpo.pe/>

if exists('g:loaded_sensible') || &compatible
  finish
endif
let g:loaded_sensible = 1

filetype plugin indent on
if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif

set backspace=indent,eol,start
set complete-=i
set showmatch

set autoindent
set smarttab

set ttimeout
set ttimeoutlen=50

if has('extra_search')
  set incsearch
endif
set smartcase
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohls<CR><C-L>
endif

set laststatus=2
if has('cmdline_info')
  set ruler
  set showcmd
endif
if has('wildmenu')
  set wildmenu
endif

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
set autowrite
set fileformats=unix,dos,mac

set viminfo+=!

if isdirectory(expand('~/.cache/vim'))
  if &directory =~# '^\.,'
    set directory^=~/.cache/vim/swap//
  endif
  if &backupdir =~# '^\.,'
    set backupdir^=~/.cache/vim/backup//
  endif
  if exists('+undodir') && &undodir =~# '^\.,'
    set undodir^=~/.cache/vim/undo//
  endif
endif
if exists('+undofile')
  set undofile
endif

if &t_Co == 8 && $TERM !~# '^linux'
  set t_Co=16
endif

if !exists('g:netrw_list_hide')
  let g:netrw_list_hide = '^\.,\~$,^tags$'
endif

if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

nnoremap Y y$

" vim:set ft=vim et sw=2:
