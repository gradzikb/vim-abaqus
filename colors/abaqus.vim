"-------------------------------------------------------------------------------
"
" Vim color file
"
" Language:    Abaqus FE solver input file
" Maintainer:  Bartosz Gradzik <bartosz.gradzik@hotmail.com>
"
" Last Change: 13.05.2015
" - non-default colors for popup menu set
"
" Last Change: 1st of January 2014
" - color scheme updated for Abaqus filetye plugin
"
" Maintainer:  Thorsten Maerz <info@netztorte.de>
" Last Change: 2006 Dec 07
" - base color scheme
" - grey on black
" - optimized for TFT panels
"
"-------------------------------------------------------------------------------

set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif
"colorscheme default
let g:colors_name = "abaqus"

" hardcoded colors :
" GUI Comment : #80a0ff = Light blue

" GUI
highlight Normal     guifg=Grey80	guibg=Black
highlight Search     guifg=Black	guibg=Red	gui=bold
highlight Visual     guifg=Grey25			gui=bold
highlight Cursor     guifg=Black	guibg=Green	gui=bold
highlight Special    guifg=Orange
highlight Comment    guifg=LightRed
highlight StatusLine guifg=blue		guibg=white
highlight Statement  guifg=Yellow			gui=NONE
highlight Type						gui=NONE

" Console
highlight Normal     ctermfg=LightGrey	ctermbg=Black
highlight Search     ctermfg=Black	ctermbg=Red	cterm=NONE
highlight Visual					cterm=reverse
highlight Cursor     ctermfg=Black	ctermbg=Green	cterm=bold
highlight Special    ctermfg=Brown
highlight Comment    ctermfg=LightRed
highlight StatusLine ctermfg=blue	ctermbg=white
highlight Statement  ctermfg=Yellow			cterm=NONE
highlight Type						cterm=NONE

" popup menu colors
highlight Pmenu guibg=black guifg=white
highlight PmenuSel guibg=white guifg=black

