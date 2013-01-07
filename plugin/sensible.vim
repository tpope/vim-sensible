" sensible.vim - Defaults everyone can agree on
" Maintainer:   Tim Pope <http://tpo.pe/>

" Don't configure if one requests vi-compatible mode.
if exists('g:loaded_sensible') || &compatible
  finish
endif
let g:loaded_sensible = 1

" Turn on filetype plugins (:help filetype-plugin).
filetype plugin indent on
if !exists('g:syntax_on')
  syntax enable
endif

" Backspace through everything in insert mode.
set backspace=indent,eol,start  

" Don't scan included files. Tags file is more performant.
set complete-=i

" When inserting paren, jump briefly to matching one.
set showmatch

" Autoindent when starting new line, or using "o" or "O".
set autoindent

" Use 'shiftwidth' when using <Tab> in front of a line.
" By default it's used only for shift commands ("<", ">").
set smarttab

" Allow for mappings including Esc, while preserving
" no timeout after pressing it manually.
set ttimeout
set ttimeoutlen=50

" Enable incremential search.
set incsearch

" Don't ignore case when search has capital letters.
" (although also don't ignore case by default).
set smartcase

" <C-L> in normal mode removes highlight on search matches.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohls<CR><C-L>
endif

" Always show window statuses, even if there's only one.
set laststatus=2

" Show the line and column number of the cursor position.
set ruler

" Show the size of block one selected in visual mode.
set showcmd

" Autocomplete commands using nice menu in place of window status.
set wildmenu

" Keep one line above or below the cursor when scrolling.
set scrolloff=1

" Keep 5 columns next to the cursor when scrolling horizontally.
set sidescrolloff=5

" When 'wrap' is on, display last line even if it doesn't fit.
set display+=lastline

" Show all whitespaces by default.
if !&list && &listchars ==# 'eol:$'
  set list
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
  if &termencoding ==# 'utf-8' || &encoding ==# 'utf-8'
    let &listchars = "tab:\u21e5 ,trail:\u2423,extends:\u21c9,precedes:\u21c7,nbsp:\u26ad"
    let &fillchars = "vert:\u259a,fold:\u00b7"
  endif
endif

" Reload unchanged files automatically.
set autoread

" Automatically save file as buffer goes away.
set autowrite

" Support all kind of EOLs by default.
set fileformats=unix,dos,mac

" Always save upper case variables to viminfo file.
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

" Allow color schemes do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^linux'
  set t_Co=16
endif

" Hide dotfiles, backup files and tag files by default.
if !exists('g:netrw_list_hide')
  let g:netrw_list_hide = '^\.,\~$,^tags$'
endif

" Load the version of matchit.vim that ships with Vim.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

" Y yanks from the cursor to the end of line as expected. See :help Y.
nnoremap Y y$

" vim:set ft=vim et sw=2:
