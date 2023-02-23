" sensible.vim - Defaults everyone can agree on
" Maintainer:   Tim Pope <http://tpo.pe/>
" Version:      1.2

if exists('g:loaded_sensible') || &compatible
  finish
else
  let g:loaded_sensible = 'yes'
endif

if !(exists('g:did_load_filetypes') && exists('g:did_load_ftplugin') && exists('g:did_indent_on'))
  filetype plugin indent on
endif
if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif

" Use :help 'option' to see the documentation for the given option.

" Check if an option was set from a file in $HOME.  This lets us avoid
" overriding options in the user's vimrc, but still override options in the
" system vimrc.
function! s:MaySet(option) abort
  if exists('*execute')
    let out = execute('verbose setglobal all ' . a:option . '?')
  else
    redir => out
    silent verbose execute 'setglobal all' a:option . '?'
    redir END
  endif
  return out !~# " \\~[\\/][^\n]*$"
endfunction

if s:MaySet('backspace')
  set backspace=indent,eol,start
endif
" Disable completing keywords in included files (e.g., #include in C).  When
" configured properly, this can result in the slow, recursive scanning of
" hundreds of files of dubious relevance.
set complete-=i
if s:MaySet('smarttab')
  set smarttab
endif

set nrformats-=octal

" Make the escape key more responsive by decreasing the wait time for an
" escape sequence (e.g., arrow keys).
if !has('nvim') && &ttimeoutlen == -1
  set ttimeout
  set ttimeoutlen=100
endif

if has('reltime') && s:MaySet('incsearch')
  set incsearch
endif
" Use CTRL-L to clear the highlighting of 'hlsearch' (off by default) and call
" :diffupdate.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

if s:MaySet('laststatus')
  set laststatus=2
endif
if s:MaySet('ruler')
  set ruler
endif
if s:MaySet('wildmenu')
  set wildmenu
endif

if s:MaySet('scrolloff')
  set scrolloff=1
endif
if s:MaySet('sidescroll') && s:MaySet('sidescrolloff')
  set sidescroll=1
  set sidescrolloff=2
endif
set display+=lastline
if has('patch-7.4.2109')
  set display+=truncate
endif

if s:MaySet('listchars')
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

" Delete comment character when joining commented lines.
if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j
endif

" Replace the check for a tags file in the parent directory of the current
" file with a check in every ancestor directory.
if has('path_extra') && (',' . &g:tags . ',') =~# ',\./tags,'
  setglobal tags-=./tags tags-=./tags; tags^=./tags;
endif

if s:MaySet('autoread')
  set autoread
endif

if s:MaySet('history')
  set history=1000
endif
if s:MaySet('tabpagemax')
  set tabpagemax=50
endif

" Persist g:UPPERCASE variables, used by some plugins, in .viminfo.
if !empty(&viminfo)
  set viminfo^=!
endif
" Saving options in session and view files causes more problems than it
" solves, so disable it.
set sessionoptions-=options
set viewoptions-=options

" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^Eterm'
  set t_Co=16
endif

" If the running Vim lacks support for the Fish shell, use Bash instead.
if &shell =~# 'fish$' && (v:version < 704 || v:version == 704 && !has('patch276'))
  set shell=/usr/bin/env\ bash
endif

" Disable a legacy behavior that can break plugin maps.
if has('langmap') && exists('+langremap') && &langremap && s:MaySet('langremap')
  set nolangremap
endif

if empty(mapcheck('<C-U>', 'i'))
  inoremap <C-U> <C-G>u<C-U>
endif
if empty(mapcheck('<C-W>', 'i'))
  inoremap <C-W> <C-G>u<C-W>
endif

" From `:help :DiffOrig`.
if exists(":DiffOrig") != 2
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_
        \ | diffthis | wincmd p | diffthis
endif

" Correctly highlight $() and other modern affordances in filetype=sh.
if !exists('g:is_posix') && !exists('g:is_bash') && !exists('g:is_kornshell') && !exists('g:is_dash')
  let g:is_posix = 1
endif

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

" Enable the :Man command shipped inside Vim's man filetype plugin.
if exists(':Man') != 2 && !exists('g:loaded_man') && &filetype !=? 'man' && !has('nvim')
  runtime ftplugin/man.vim
endif
