"-------------------------------------------------------------------------------
"
" Vim color file
"
" Language:    Abaqus FE solver input file
" Maintainer:  Bartosz Gradzik <bartosz.gradzik@hotmail.com>
"
" Last Change: 24.07.2016
" - color scheme improved
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
highlight clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "abaqus"

"-------------------------------------------------------------------------------
"    VIM GROUPS
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" GUI

highlight Normal     guifg=White     guibg=Black    gui=NONE
highlight Search     guifg=Black     guibg=Red      gui=NONE
highlight Visual     guifg=Black     guibg=DarkGray gui=NONE
highlight Folded     guifg=LightGray guibg=Gray40   gui=NONE
highlight Cursor     guifg=bg        guibg=fg       gui=NONE
highlight CursorLine guifg=NONE      guibg=Gray20   gui=NONE
highlight StatusLine guifg=White     guibg=Blue     gui=NONE
highlight Pmenu      guifg=white     guibg=black    gui=NONE
highlight PmenuSel   guifg=black     guibg=white    gui=NONE

"-------------------------------------------------------------------------------
" Terminal

highlight Normal     ctermfg=Gray      ctermbg=Black     cterm=NONE
highlight Search     ctermfg=Black     ctermbg=Red       cterm=NONE
highlight Visual     ctermfg=Black     ctermbg=Gray      cterm=NONE
highlight Folded     ctermfg=Black     ctermbg=Gray      cterm=NONE
highlight Cursor     ctermfg=bg        ctermbg=fg        cterm=NONE
highlight CursorLine ctermfg=NONE      ctermbg=NONE      cterm=Underline
highlight StatusLine ctermfg=Black     ctermbg=White     cterm=NONE
highlight Pmenu      ctermfg=white     ctermbg=black     cterm=NONE
highlight PmenuSel   ctermfg=black     ctermbg=white     cterm=NONE

"-------------------------------------------------------------------------------
"    LS-DYNA HIGHLIGHT COLORS
"-------------------------------------------------------------------------------
"
"-------------------------------------------------------------------------------
" GUI

highlight abaqusComment       guifg=LightRed  guibg=bg    gui=NONE
highlight abaqusError         guifg=White     guibg=Red   gui=NONE
highlight abaqusKeywordName   guifg=Yellow    guibg=bg    gui=NONE
highlight abaqusKeywordOption guifg=Cyan      guibg=bg    gui=NONE
highlight abaqusKeywordValue  guifg=LightRed  guibg=bg    gui=NONE

"-------------------------------------------------------------------------------
" Terminal

highlight abaqusComment       ctermfg=Red       ctermbg=bg    cterm=NONE
highlight abaqusError         ctermfg=White     ctermbg=Red   cterm=NONE
highlight abaqusKeywordName   ctermfg=Yellow    ctermbg=bg    cterm=NONE
highlight abaqusKeywordOption ctermfg=Cyan      ctermbg=bg    cterm=NONE
highlight abaqusKeywordValue  ctermfg=Red       ctermbg=bg    cterm=NONE

"-------------------------------------EOF---------------------------------------
