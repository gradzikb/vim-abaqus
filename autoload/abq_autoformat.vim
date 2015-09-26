"-------------------------------------BOF---------------------------------------
"
" Vim filetype plugin file
"
" Language:     VIM Script
" Filetype:     Abaqus FE solver input file
" Maintainer:   Bartosz Gradzik <bartosz.gradzik@hotmail.com>
" Last Change:  26th of September 2015
"
"-------------------------------------------------------------------------------
"
" v1.0.1
"   - amplitude dataline support parameter as well
"
" v1.0.0
"   - initial version
"
"-------------------------------------------------------------------------------

function! abq_autoformat#Clean(str)

  "-----------------------------------------------------------------------------
  " Function to clean raw string (remove leading and trailing white signs).
  "
  " Arguments:
  " - str (string) : string to clean
  " Return:
  " - str (string) : clean string
  "-----------------------------------------------------------------------------

  " remove leading asteriks and leading spaces
  let str = substitute(a:str, "^\*\\?\\s*", "", "")
  " remove trailing spaces
  let str = substitute(str, "\\s*$", "", "")
  " keep only one space between words
  " let str = substitute(str, "\\a\\s\\+\\a", " ", "")

  return str

endfunction

"-------------------------------------------------------------------------------

function! abq_autoformat#FindKeyword()

  "-----------------------------------------------------------------------------
  " Function to find first and last keyword line in inputdeck.
  "
  " Arguments:
  " - None
  " Return:
  " - kwStart, kwEnd (list) : line number with start and end
  "-----------------------------------------------------------------------------

  " find start of keyword
  let kwStart = search('^\*\a','bcnW')

  " find end of keyword
  let kwEnd = kwStart

  while 1

    "get line
    let line = getline(kwEnd)

    " if coma at the end move one line forward
    if line =~? '\s*,\s*$'
      let kwEnd += 1
    "  if not stop loop
    else
      break
    endif

  endwhile

  return [kwStart, kwEnd]

endfunction

"-------------------------------------------------------------------------------

function! abq_autoformat#GetKeyword(start, end)

  "-----------------------------------------------------------------------------
  " Function to take keyword from inputdeck and build internal representation
  "
  " Arguments:
  " - kwStart (number) : line number with start of keyword
  " - kwEnd (number)   : line number with end of keyword
  " Return:
  " - kwRepr (dict) : internal keyword representation
  "-----------------------------------------------------------------------------

  " get all keyword lines
  let kwLine = ""
  for lnum in range(a:start, a:end)

    let line = getline(lnum)
    let kwLine = kwLine . line

  endfor

  " list with keyword definition
  let kwList = split(kwLine, '\s*,\s*')

  " build keyword dictionary representation
  let kwDef = {}
  let kwName = tolower(abq_autoformat#Clean(kwList[0]))
  let kwDef[kwName] = {}

  " loop over keyword options
  for i in range(1, len(kwList)-1)

    let kw = kwList[i]
    if match(kw, '=') == -1
      let optName = tolower(abq_autoformat#Clean(kw))
      let optVal = ""
      let kwDef[kwName][optName] = optVal
    else
      let kwTmp = split(kw, '\s*=\s*')
      let optName = tolower(abq_autoformat#Clean(kwTmp[0]))
      let optVal  = abq_autoformat#Clean(kwTmp[1])
      let kwDef[kwName][optName] = optVal
    endif

  endfor

  return kwDef

endfunction

"-------------------------------------------------------------------------------

function! abq_autoformat#DumpKeyword(start, end, kw)

  "-----------------------------------------------------------------------------
  " Function to write keyword definition in the file.
  "
  " Arguments:
  " - kwStart (number) : line number with start of keyword
  " - kwEnd (number)   : line number with end of keyword
  " - kw (dict)        : internal keyword representation
  " Return:
  " - None
  "-----------------------------------------------------------------------------

  " get keyword name
  let kwName = keys(a:kw)[0]

  " get keyword options & sort
  let kwOpt = sort(keys(a:kw[kwName]))
  let kwOptLen = len(kwOpt)

  " move 'elset' to the beginning
  let optPos = index(kwOpt, 'elset')
  if optPos != -1
      " move to first position
      call remove(kwOpt, optPos)
      call insert(kwOpt, 'elset')
  endif

  " move 'nset' to the beginning
  let optPos = index(kwOpt, 'nset')
  if optPos != -1
      " move to first position
      call remove(kwOpt, optPos)
      call insert(kwOpt, 'nset')
  endif

  " move 'name' to the beginning
  let optPos = index(kwOpt, 'name')
  if optPos != -1
      " move to first position
      call remove(kwOpt, optPos)
      call insert(kwOpt, 'name')
  endif

  " how long line do I need to put everything into one line?
  let kwLen = len(kwName) + 3
  for opt in kwOpt
    let optLen = len(opt) + 1
    let valLen = len(a:kw[kwName][opt]) + 1
    let kwLen = kwLen + optLen + valLen
  endfor

  " remove old lines
  execute a:start . "," . a:end . "delete"
  normal! k

  " save all in one line
  if kwLen <= 80

    " do not add coma is only keyword
    if kwOptLen == 0
      let newLine =  '*' . toupper(kwName)
    else
      let newLine =  '*' . toupper(kwName) . ', '
    endif

    for i in range(kwOptLen)

     " get keyword option
     let kwo = toupper(kwOpt[i])

     " get keyword value
     let kwv = a:kw[kwName][kwOpt[i]]
     if kwv != ""
       let kwv = '=' . kwv
     endif

      " add comma after word if not last
      if i == kwOptLen-1
        let coma = ""
      else
        let coma = ", "
      endif

     " extend line with new options
     let newLine = newLine . kwo . kwv . coma

    endfor

    " write line
    normal! o
    call setline(".", newLine)

  " more than 80 signs ... split into many lines
  else

    let kwn = '*' . toupper(kwName)
    let kwo = toupper(kwOpt[0])
    let kwv = a:kw[kwName][kwOpt[0]]

    let kwnLen = len(kwn) + 2

    " build 1st line
    if kwv == ""
      let newLine = kwn . ', ' . kwo . ','
    else
      let newLine = kwn . ', ' . kwo . '=' . kwv . ','
    endif

    " write line
    normal! o
    call setline(".", newLine)

    " loop for other lines
    for i in range(1, kwOptLen-1)

      " add comma after word if not last
      if i == kwOptLen-1
        let coma = ""
      else
        let coma = ","
      endif

      let kwo = toupper(kwOpt[i])
      let kwv = a:kw[kwName][kwOpt[i]]

      " build line
      if kwv == ""
        let newLine = repeat(" ", kwnLen) . kwo . coma
      else
        let newLine = repeat(" ", kwnLen) .kwo . '=' . kwv . coma
      endif
      " write line
      normal! o
      call setline(".", newLine)

    endfor

  endif

endfunction

"-------------------------------------------------------------------------------

function! abq_autoformat#AmpDataline(start, end)

  "-----------------------------------------------------------------------------
  " Function to format data lines of *AMPLITUDE keyword.
  "
  " Arguments:
  " - start (number) : first dataline
  " - start (number) : end dataline
  " Return:
  " - None
  "-----------------------------------------------------------------------------

  " creat empty list to store data
  let points = []

  " read lines and store data into the list
  for i in range(a:start, a:end)
    let points = points + split(getline(i), '\s*,\s*\|\s\+')
  endfor

  " remove old lines
  execute a:start . "," . a:end . "delete"

  " move one line up
  normal! k

  " save points into the file
  for i in range(0, len(points)-1, 2)

    " save new lines
    let newLine = printf("%16s%1s%15s", points[i], ",", points[i+1])
    normal! o
    call setline('.', newLine)

  endfor

endfunction

"-------------------------------------------------------------------------------

function! abq_autoformat#AbaqusLine() range

  "-----------------------------------------------------------------------------
  " Function to autformat Abaqus line.
  "
  " Arguments:
  " - None
  " Return:
  " - None
  "-----------------------------------------------------------------------------

  " get current line
  let line = getline(a:firstline)

  "-----------------------------------------------------------------------------
  " comment line

  if line =~? '^\s*\*\*'

    " remove leading white signs
    silent execute a:firstline . ',' . a:lastline . 's/^\s*//'
    " move cursor to next line
    call cursor(a:lastline+1, 0)

  "-----------------------------------------------------------------------------
  " amplitude dataline

  elseif line !~? '=' && line=~? '^[ <>0-9.eE+\-]\+,\?[ <>0-9.eE+\-]\+'

    " format amplitude datalines
    call abq_autoformat#AmpDataline(a:firstline, a:lastline)
    " move cursor to next line
    normal! j

  "-----------------------------------------------------------------------------
  " abaqus keyword

  else

    " find keyword lines
    let kwLines = abq_autoformat#FindKeyword()
    " grap keyword from inputdeck
    let kwDef = abq_autoformat#GetKeyword(kwLines[0], kwLines[1])
    " write keyword in new format
    call abq_autoformat#DumpKeyword(kwLines[0], kwLines[1], kwDef)

  endif

endfunction

"-------------------------------------EOF---------------------------------------
