"-------------------------------------BOF---------------------------------------
"
" Vim syntax file
"
" Language:     Abaqus FE solver input file
" Maintainer:   Bartosz Gradzik (bartosz.gradzik@hotmail.com)
" Last Change:  22th of November 2014
" Version:      1.0.0
"
" History of change:
" v1.0.0
"   - initial version base on default Abaqus syntax file from VIM
"     installation directory by Carl Osterwisch <osterwischc@asme.org>
"
"-------------------------------------------------------------------------------

" check if syntax is already loaded
if exists("b:current_syntax") | finish | endif
" set flag when abaqus syntax is loaded
let b:current_syntax = "abaqus"

"-------------------------------------------------------------------------------

syntax match abqComment '^\*\*.*$'
syntax match abqErrorLine1 '^\s\+\*.*$'
syntax match abqErrorLine2 '^\*\s*$'
syntax match abqNextLine ',$' contained
syntax match abqKeywordName '^\*\a[^,]*' contained
syntax match abqKeywordOption1 ',\s*[^=,]*'lc=1 contained
syntax match abqKeywordOption2 '^\s*\a[^=,]*' contained
syntax match abqKeywordValue '=[^,]*'lc=1 contained

highlight default link abqComment Comment
highlight default link abqErrorLine1 Error
highlight default link abqErrorLine2 Error
highlight default link abqKeywordName Statement
highlight default link abqKeywordOption1 Identifier
highlight default link abqKeywordOption2 Identifier
highlight default link abqKeywordValue Constant

syntax cluster abqKeywordCluster add=abqComment
syntax cluster abqKeywordCluster add=abqErrorLine1
syntax cluster abqKeywordCluster add=abqErrorLine2
syntax cluster abqKeywordCluster add=abqNextLine
syntax cluster abqKeywordCluster add=abqKeywordName
syntax cluster abqKeywordCluster add=abqKeywordOption1
syntax cluster abqKeywordCluster add=abqKeywordOption2
syntax cluster abqKeywordCluster add=abqKeywordValue

syntax region abqKeyword start=/^\*\a/ end=/$/
 \ contains=@abqKeywordCluster

"-------------------------------------EOF---------------------------------------
