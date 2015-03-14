"-------------------------------------BOF---------------------------------------
"
" Vim filetype plugin file
"
" Language:     VIM Script
" Filetype:     Abaqus FE solver input file
" Maintainer:   Bartosz Gradzik <bartosz.gradzik@hotmail.com>
" Last Change:  22th of November 2014
"
"-------------------------------------------------------------------------------
"
" v1.0.0
"   - initial version
"
"-------------------------------------------------------------------------------

function! abq_library#clean(str, flag)

  "-----------------------------------------------------------------------------
  " Function to clean raw string (remove leading and trailing white signs).
  "
  " Arguments:
  " - str (string)  : string to clean
  " - flag (number) : 0 - do not remove equal sign
  "                 : 1 - remove equal sign
  " Return:
  " - str (string) : clean string
  "-----------------------------------------------------------------------------

  " remove leading asteriks and leading spaces
  let str = substitute(a:str, "^\*\\?\\s*", "", "")
  " remove everything after =
  if a:flag == 1
    let str = substitute(str, "=.*$", "", "")
  endif
  " remove trailing spaces
  let str = substitute(str, "\\s*$", "", "")
  " change to lowercase
  let str = toupper(str)

  return str

endfunction

"-------------------------------------------------------------------------------

function! abq_library#getKeyword()

  "-----------------------------------------------------------------------------
  " Function to read keyword from inputdeck with all options.
  "
  " Arguments:
  " - None
  " Return:
  " - kwDict (list) : keyword definition
  "-----------------------------------------------------------------------------

  " keyword definition start
  let kwStart = search('^\*\a','bcnW')

  " keyword definition end
  " go from current line forward and stop if not keyword line
  " this is not perfect, in some cases can take also datalines
  let lnum = line('.')
  while 1
    let line = getline(lnum+1)
    if line =~? '^\*'
      break
    elseif line =~? '='
      let lnum += 1
    elseif line =~? '^\s*\a\{1,}\s*\(,\|$\)'
      let lnum += 1
    else
      break
    endif
  endwhile
  let kwEnd = lnum

  " get all keyword lines
  let kwLine = ""
  for lnum in range(kwStart, kwEnd)

    " join all lines into one
    let line = getline(lnum)
    if line != "" && line !~? ',\s*$'
      let line = line . ','
    endif
    let kwLine = kwLine . line

  endfor

  " clean data-in
  let keyw = map(split(kwLine, '\s*,\s*'), 'abq_library#clean(v:val,1)')

  " build keyword dictionary representation
  let kwDict = {}
  let kwName = keyw[0]
  let kwDict[kwName] = []
  for i in range(1, len(keyw)-1)
    call add(kwDict[kwName], keyw[i])
  endfor

  return kwDict

endfunction

"-------------------------------------------------------------------------------

function! abq_library#evalKeyword(kwInp, kwLib)

  "-----------------------------------------------------------------------------
  " Function to cross check keyword from inputdeck and from library.
  "
  " Arguments:
  " - kwInp(dict) : keyword from inputdeck
  " - kwLib(dict) : keyword library
  " Return:
  " - kwOptNotUsed (list) : options which are not used yet
  "-----------------------------------------------------------------------------

  " get kw name
  let kwName = keys(a:kwInp)[0]

  " check if kw is in the library
  if !has_key(a:kwLib, kwName)
    return []
  endif

  " check which options are already in use and remove them
  let kwOptNotUsed = copy(a:kwLib[kwName])
  for kwOpt in a:kwInp[kwName]
    let regPat = '^' . kwOpt . '=\?\(\a\|\s\)*$'
    call filter(kwOptNotUsed, 'v:val !~? regPat')
  endfor

  return kwOptNotUsed

endfunction

"-------------------------------------------------------------------------------

function! abq_library#initLib(path)

  "-----------------------------------------------------------------------------
  " Function to initialize abaqus keyword library.
  "
  " Arguments:
  " - path (string) : path to directory with keyword files
  " Return:
  " - keyLib (dict) : keywords and list of their options
  "-----------------------------------------------------------------------------

  " get all *.inp files from keyword directory
  let files = split(globpath(a:path, '**/*.inp'))

  " initialize abaqus library
  let keyLib = {}

  " loop over the files
  for file in files

    " read all lines from file and clean them
    let lines = map(readfile(file), 'abq_library#clean(v:val,0)')

    " add keyword to library
    let keyName = lines[0]
    if !has_key(keyLib, keyName)
      let keyLib[keyName] = []
      for i in range(1, len(lines)-1)
        call add(keyLib[keyName], lines[i])
      endfor
    endif

  endfor

  return keyLib

endfunction

"-------------------------------------------------------------------------------

function! abq_library#omniComp(findstart, base)

  "-----------------------------------------------------------------------------
  " User completion function used with keyword library.
  "
  " Arguments:
  " - see :help complete-functions
  " Return:
  " - see :help complete-functions
  "-----------------------------------------------------------------------------

  " run for 1st function call
  if a:findstart

    "get current line
    let line = getline('.')

    " if only keyword name grap whole line
    if line =~? '^\*\a[^,]*$'
      let start = 0
    " in other case start looking beginning of completion
    else
      " find coma, space or beginning of line
      let start = col('.') - 1
      while start > 0 && line[start-1] !~? '\s\|,'
        let start -= 1
      endwhile
    endif

    return start

  " run for 2nd function call
  else

    let compRes = []

    " complete keyword name
    if a:base[0] == '*'

      " completion loop
      for kwName in sort(keys(g:abqKeyLib))
        if kwName =~? '^' . a:base[1:]
          call add(compRes, '*' . kwName)
        endif
      endfor

    " complete keyword option
    else

      " get keyword definition
      let kw = abq_library#getKeyword()
      echom string(kw)
      " crosscheck with keyword library
      let kwOptions = abq_library#evalKeyword(kw, g:abqKeyLib)

      " completion loop
      for optName in sort(kwOptions)
        if optName =~? '^' . a:base
          call add(compRes, optName)
        endif
      endfor

    endif

    return compRes

  endif

endfunction

"-------------------------------------EOF---------------------------------------
