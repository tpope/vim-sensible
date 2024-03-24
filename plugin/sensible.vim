" sensible.vim - Defaults everyone can agree on
" Maintainer:   Tim Pope <http://tpo.pe/>
" Version:      2.0

if exists('g:loaded_sensible') || &compatible
  finish
else
  let g:loaded_sensible = 'yes'
endif

" Use :help 'option' to see the documentation for the given option.

" Disable vi compatibility, if for some reason it's on.
if &compatible
  set nocompatible
endif

if exists('*execute')
  let s:Execute = function('execute')
else
  function! s:Execute(cmd) abort
    redir => out
    silent verbose execute a:cmd
    redir END
    return out
  endfunction
endif

let s:defaultval_yes  = ['set ', '']
let s:defaultval_no = ['set no', '']
let s:defaultval_checked = ['" ', '']  " translates to comment -> no :set
let s:default_opts = []
let s:default_vals = {}
let s:option_query_str = ' '
let s:option_not_queried = { }
function! s:AddOptionQuery(option)
  let s:option_not_queried[a:option] = 0
  let s:option_query_str .= a:option . '? '
endfunction
function! s:DefaultSet(option, setcmd, query_it = 1) abort
  if ! a:query_it || exists('&' . a:option)
    if a:query_it
      call s:AddOptionQuery(a:option)
    endif
    call add(s:default_opts, a:option)
    let s:default_vals[a:option] = a:setcmd[0] . a:option . a:setcmd[1]
  endif
endfunction
function! s:DefaultMod(option, mod, value, query_it = 1) abort
  call s:DefaultSet(a:option, ['set ', a:mod . a:value], a:query_it)
endfunction
function! s:Default(option, value, query_it = 1) abort
  call s:DefaultSet(a:option, ['set ', '=' . a:value], a:query_it)
endfunction

call s:Default('backspace', 'indent,eol,start')
" Disable completing keywords in included files (e.g., #include in C).  When
" configured properly, this can result in the slow, recursive scanning of
" hundreds of files of dubious relevance.
call s:DefaultMod('complete', '-=', 'i', 0)
call s:DefaultSet('smarttab', s:defaultval_yes)

call s:DefaultMod('nrformats', '-=', 'octal', 0)

" Make the escape key more responsive by decreasing the wait time for an
" escape sequence (e.g., arrow keys).
if !has('nvim') && &ttimeoutlen == -1
  call s:DefaultSet('ttimeout', s:defaultval_yes, 0)
  call s:Default('ttimeoutlen', '100', 0)
endif

if has('reltime')
  call s:DefaultSet('incsearch', s:defaultval_yes)
endif
" Use CTRL-L to clear the highlighting of 'hlsearch' (off by default) and call
" :diffupdate.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

call s:Default('laststatus', '2')
call s:DefaultSet('ruler', s:defaultval_yes)
call s:DefaultSet('wildmenu', s:defaultval_yes)

call s:Default('scrolloff', '1')

call s:AddOptionQuery('sidescroll')
call s:AddOptionQuery('sidescrolloff')
" call at the end
function! s:SetSidescroll() abort
  if s:MaySet('sidescroll') && s:MaySet('sidescrolloff')
    set sidescroll=1
    set sidescrolloff=2
  endif
endfunction

let s:display_mods='lastline'
if has('patch-7.4.2109')
  let s:display_mods .= ',truncate'
endif
call s:DefaultMod('display', '+=', s:display_mods, 0)

call s:Default('listchars', 'tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+')

" Delete comment character when joining commented lines.
if v:version > 703 || v:version == 703 && has("patch541")
  call s:DefaultMod('formatoptions', '+=', 'j', 0)
endif

" Replace the check for a tags file in the parent directory of the current
" file with a check in every ancestor directory.
if has('path_extra') && (',' . &g:tags . ',') =~# ',\./tags,'
  setglobal tags-=./tags tags-=./tags; tags^=./tags;
endif

call s:DefaultSet('autoread', s:defaultval_yes)

call s:Default('history', '1000')
call s:Default('tabpagemax', '50')

" Persist g:UPPERCASE variables, used by some plugins, in .viminfo.
if !empty(&viminfo)
  set viminfo^=!
endif
" Saving options in session and view files causes more problems than it
" solves, so disable it.
call s:DefaultMod('sessionoptions', '-=', 'options', 0)
call s:DefaultMod('viewoptions', '-=', 'options', 0)

" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^Eterm'
  call s:Default('t_Co', '16', 0)
endif

" If the running Vim lacks support for the Fish shell, use Bash instead.
if &shell =~# 'fish$' && (v:version < 704 || v:version == 704 && !has('patch276'))
  call s:Default('shell', '/usr/bin/env\ bash', 0)
endif

" Disable a legacy behavior that can break plugin maps.
if has('langmap') && exists('+langremap') && &langremap
  call s:DefaultSet('langremap', s:defaultval_no)
endif

function! s:CheckDefaults() abort
  let s:global_settings = s:Execute('verbose setglobal all lines? ' . s:option_query_str)
  " 'lines=' delimits the start of the answer
  let s:global_settings = substitute(s:global_settings, '.*lines=[^\n]*', '', '') . "\n"
  " ^ begins and ends in newline
endfunction

" Check if an option was set from a file in $HOME.  This lets us avoid
" overriding options in the user's vimrc, but still override options in the
" system vimrc.
let s:homerx = " \\(\\~[\\/][^\n]*\\|Lua\\)\n"
function! s:MaySet(option) abort
  "return s:Execute('verbose setglobal all ' . a:option . '?') . "\n" !~# s:homerx  " previous version
  return get(s:option_not_queried, a:option, 1) || s:global_settings !~# ('\n\(\s\+\|no\)\?' . a:option . '\(=[^\n]*\n\|\n\)' . '[^\n]*' . s:homerx)
endfunction

function! s:ComputeSettings() abort
  call filter(s:default_opts, 's:MaySet(v:val)')
  return join(map(s:default_opts, 's:default_vals[v:val]'), "\n")
endfunction

call s:CheckDefaults()
let s:computed_settings = s:ComputeSettings()
call s:Execute(s:computed_settings)
call s:SetSidescroll()

if !(exists('g:did_load_filetypes') && exists('g:did_load_ftplugin') && exists('g:did_indent_on'))
  filetype plugin indent on
endif
if has('syntax') && !exists('g:syntax_on')
  syntax enable
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

function! s:GetComputedSettings() abort  " DEBUG: call with <SNR> from :scriptnames
  return s:computed_settings
endfun
