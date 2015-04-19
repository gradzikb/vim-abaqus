"-------------------------------------BOF---------------------------------------
"
" Vim filetype plugin file
"
" Language:     VIM Script
" Filetype:     Abaqus FE solver input file
" Maintainer:   Bartosz Gradzik <bartosz.gradzik@hotmail.com>
" Last Change:  19th of April 2015
"
"-------------------------------------------------------------------------------
"
" v1.0.0
"   - initial version
"
"-------------------------------------------------------------------------------

function! abq_templates#CompleteKeywords(findstart, base)

  "-----------------------------------------------------------------------------
  " User completion function used with template library.
  "
  " Arguments:
  " - see :help complete-functions
  " Return:
  " - see :help complete-functions
  "-----------------------------------------------------------------------------

  " run for first function call
  if a:findstart

    " start from the beginning of the line
    return 0

  else

    " get list of templates in the library
    let temLib = split(globpath(g:abaqusTemLibPath, '*.inp'))
    " keep only file names without extension
    call map(temLib, 'fnamemodify(v:val, ":t:r")')

    " completion loop
    let compKeywords = []
    for key in temLib
      if key =~? '^' . a:base
        call add(compKeywords, key)
      endif
    endfor

    " set completion flag
    let b:abaqusUserComp = 1
    " return list after completion
    return compKeywords

  endif

endfunction

"-------------------------------------------------------------------------------

function! abq_templates#GetCompletion()

  "-----------------------------------------------------------------------------
  " Function to take template name from current line and insert keyword
  " definition from the library.
  "
  " Arguments:
  " - None
  " Return:
  " - None
  "-----------------------------------------------------------------------------

  " save unnamed register
  let tmpUnnamedReg = @@

  " get template name
  let tmpName = getline('.')
  " set template file path
  let file = g:abaqusTemLibPath . tmpName . ".inp"

  " check if the file exist and put it
  if filereadable(file)
   execute "read " . file
   normal! kdd
  else
    normal! <C-Y>
  endif

  " restore unnamed register
  let @@ = tmpUnnamedReg

  " reset completion flag
  let b:abaqusUserComp = 0

endfunction

"-------------------------------------EOF---------------------------------------
