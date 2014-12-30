"-------------------------------------BOF---------------------------------------
"
" Vim filetype plugin file
"
" Language:     Abaqus FE solver input file
" Maintainer:   Bartosz Gradzik <bartosz.gradzik@hotmail.com>
" Last Change:  15th of November 2014
" Version:      1.1.1
"
" History of change:
" v1.0.0
"   - initial version base on default Abaqus ftplugin from VIM
"     installation directory by Carl Osterwisch <osterwischc@asme.org>
"
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
"    FILETYPE PLUGIN SETTINGS
"-------------------------------------------------------------------------------

" check if the plugin is already load into current buffer
if exists("b:did_ftplugin") | finish | endif
" set flag when ls-dyna filetype plugin is loaded
let b:did_ftplugin = "abaqus"
" save current compatible settings
let s:cpo_save = &cpo
" reset vim to default settings
set cpo&vim

"-------------------------------------------------------------------------------
"    COLORS
"-------------------------------------------------------------------------------

colorscheme abaqus

"-------------------------------------------------------------------------------
"    SPECIAL SIGNS
"-------------------------------------------------------------------------------

" add special signs
setlocal iskeyword+=;
setlocal iskeyword+=-

"-------------------------------------------------------------------------------
"    FOLDING
"-------------------------------------------------------------------------------

" Fold all lines that do not begin with *
setlocal foldexpr=getline(v:lnum)!~?\"\^[*]\"
setlocal foldmethod=expr
setlocal foldminlines=4

"-------------------------------------------------------------------------------
"   ABBREVIATIONS
"-------------------------------------------------------------------------------

" let use [d to find *SURFACE/*ELSET/*NSET definition
setlocal define=^\\*\\a.*\\c\\(NAME\\\|NSET\\\|ELSET\\)\\s*=

"-------------------------------------------------------------------------------
"   ABBREVIATIONS
"-------------------------------------------------------------------------------

function! AbqComment()
  if getline('.')[0] == '8'
    normal! hx
    return '**'
  else
    return ''
  endif
endfunction
" change 8 -> ** but only at the beginning of the line
inoreabbrev 8 8<C-R>=AbqComment()<CR>

iabbrev bof **------------------------------------BOF---------------------------------------
iabbrev eof **------------------------------------EOF---------------------------------------

"-------------------------------------------------------------------------------
"   INCLUDES
"-------------------------------------------------------------------------------

" open in current window
nnoremap <silent><buffer> gf Vgf
" open in new window
nnoremap <silent><buffer> gF V<C-w>f<C-w>H
" define include string, let use :checkpath
setlocal include=\\cinput\\s*=
" let use <C-x><c-f> with no white sign after '='
setlocal isfname-==

" function to grap path from whole *INCLUDE line
function! AbqIncludeName(fname)
  " remove evrything befor 1st '=' sign
  let fname = substitute(a:fname,'^.\{-}=\s*','','')
  " remove evrything after ',' sign
  let fname = substitute(fname,'\s*,.*$','','')
  return fname
endfunction
setlocal includeexpr=AbqIncludeName(v:fname)

" always set current working directory respect to open file
augroup abaqusPWD
  autocmd!
  " set working directory to current file
  autocmd BufNewFile * cd %:p:h
  autocmd BufReadPost * cd %:p:h
  autocmd WinEnter * cd %:p:h
  autocmd TabEnter * cd %:p:h
augroup END

"-------------------------------------------------------------------------------
"   MAPPINGS
"-------------------------------------------------------------------------------

" mapping for separation lines
nnoremap <silent><buffer> <LocalLeader>c o**<ESC>$
nnoremap <silent><buffer> <LocalLeader>C O**<ESC>$
nnoremap <silent><buffer> <LocalLeader>1 o**<ESC>78a-<ESC>0
nnoremap <silent><buffer> <LocalLeader>! O**<ESC>78a-<ESC>0
nnoremap <silent><buffer> <LocalLeader>0 o**<ESC>78a-<ESC>yypO**<ESC>A    
nnoremap <silent><buffer> <LocalLeader>) O**<ESC>78a-<ESC>yypO**<ESC>A    

" jump to previous keyword
nnoremap <silent><buffer> [[ ?^\*\a<CR>:nohlsearch<CR>zz
" jump to next keyword
nnoremap <silent><buffer> ]] /^\*\a<CR>:nohlsearch<CR>zz

"-------------------------------------------------------------------------------
"    COMMENT FUNCTION
"-------------------------------------------------------------------------------

" prefered Alt-C but not always works ...
noremap <silent><buffer> <M-c> :call <SID>Comment()<CR>j
" ... use Ctrl-C instead
noremap <silent><buffer> <C-c> :call <SID>Comment()<CR>j

function! <SID>Comment() range

  if getline(a:firstline) =~? "^\\*\\*"
    silent execute a:firstline . ',' . a:lastline . 's/^\*\*//'
  else
    silent execute a:firstline . ',' . a:lastline . 's/^/\*\*/'
  endif

endfunction

"-------------------------------------------------------------------------------
"    KEYWORDS LIBRARY
"-------------------------------------------------------------------------------

" allow to use Ctrl-Tab for omni completion
inoremap <C-Tab> <C-X><C-O>

" set using popupmenu for completion
setlocal completeopt+=menu
setlocal completeopt+=menuone

" set path to keyword library directory
if !exists("g:abqKeyLibPath")
  let g:abqKeyLibPath = expand('<sfile>:p:h:h') . '/keywords/'
endif

" initialize abaqus keyword library
" the library is initilized only once per Vim session
if !exists("g:abqKeyLib")
  let g:abqKeyLib = abq_library#initLib(g:abqKeyLibPath)
endif

" set user completion function to run with <C-X><C-O>
setlocal omnifunc=abq_library#omniComp

"-------------------------------------------------------------------------------
"    LINE FORMATING
"-------------------------------------------------------------------------------

noremap <buffer><script><silent> <LocalLeader><LocalLeader>
 \ :call abq_autoformat#AbaqusLine()<CR>

"-------------------------------------------------------------------------------
"    COMMANDS
"-------------------------------------------------------------------------------

command! -buffer -range -nargs=* AbaqusShift
 \ :call abq_amplitudes#Shift(<line1>,<line2>,<f-args>)

command! -buffer -range -nargs=* AbaqusScale
 \ :call abq_amplitudes#Scale(<line1>,<line2>,<f-args>)

command! -buffer -range -nargs=* AbaqusResample
 \ :call abq_amplitudes#Resample(<line1>,<line2>,<f-args>)

command! -buffer -range -nargs=* AbaqusAddPoint
 \ :call abq_amplitudes#AddPoint(<line1>,<line2>,<f-args>)

command! -buffer -range AbaqusSwap
 \ :call abq_amplitudes#Swap(<line1>,<line2>)

command! -buffer -range AbaqusRefMesh
 \ :call abq_refMesh#RefMesh(<line1>,<line2>)

"-------------------------------------------------------------------------------
" restore vim functions
let &cpo = s:cpo_save

"-------------------------------------EOF---------------------------------------
