"-------------------------------------BOF---------------------------------------
"
" Vim filetype plugin file
"
" Language:     VIM Script
" Filetype:     Abaqus FE solver input file
" Maintainer:   Bartosz Gradzik <bartosz.gradzik@hotmail.com>
" Last Change:  19th of December 2015
" Version:      1.0.0
"
" History of change:
"
" v1.0.0
"   - initial version
"
"-------------------------------------------------------------------------------

function! abq_node#Shift(line1, line2, ...)

  "-----------------------------------------------------------------------------
  " Function to shift node coordinates.
  "
  " Arguments:
  " - a:line1  : first line of selection
  " - a:line2  : last line of selection
  " - a:1      : x shift value (default 0.0)
  " - a:2      : y shift value (default 0.0)
  " - a:3      : z shift value (default 0.0)
  " Return:
  " - None
  "-----------------------------------------------------------------------------

  " set user scaling factors
  if a:0 == 1
    let xSh = str2float(a:1)
    let ySh = 0.0
    let zSh = 0.0
  elseif a:0 == 2
    let xSh = str2float(a:1)
    let ySh = str2float(a:2)
    let zSh = 0.0
  elseif a:0 == 3
    let xSh = str2float(a:1)
    let ySh = str2float(a:2)
    let zSh = str2float(a:3)
  endif

  " lines loop
  for lnum in range(a:line1, a:line2)

    " get a line
    let sline = getline(lnum)

    " skip comment/keyword lines
    if sline =~? '^\*'
      continue
    endif

    " split current line
    let line = split(sline, ',')

    " get and scale node coordinates
    let nid = line[0]
    let nx = xSh + str2float(line[1])
    let ny = ySh + str2float(line[2])
    let nz = zSh + str2float(line[3])

    " dump line with new coord.
    let newline = printf("%10s%1s%15.8f%1s%15.8f%1s%15.8f", nid, ',', nx, ',', ny, ',', nz)
    call setline(lnum, newline)

  endfor

  " restore cursor position
  call cursor(a:line1, 0)

endfunction

"-------------------------------------------------------------------------------

function! abq_node#Scale(line1, line2, ...)

  "-----------------------------------------------------------------------------
  " Function to scale node coordinates.
  "
  " Arguments:
  " - a:line1  : first line of selection
  " - a:line2  : last line of selection
  " - a:1      : x scale factor (default 1.0)
  " - a:2      : y scale factor (default 1.0)
  " - a:3      : z scale factor (default 1.0)
  " Return:
  " - None
  "-----------------------------------------------------------------------------

  " set user scaling factors
  if a:0 == 1
    let xSf = str2float(a:1)
    let ySf = 1.0
    let zSf = 1.0
  elseif a:0 == 2
    let xSf = str2float(a:1)
    let ySf = str2float(a:2)
    let zSf = 1.0
  elseif a:0 == 3
    let xSf = str2float(a:1)
    let ySf = str2float(a:2)
    let zSf = str2float(a:3)
  endif

  " lines loop
  for lnum in range(a:line1, a:line2)

    " get a line
    let sline = getline(lnum)

    " skip comment/keyword lines
    if sline =~? '^\*'
      continue
    endif

    " split current line
    let line = split(sline, ',')

    " get and scale node coordinates
    let nid = line[0]
    let nx = xSf * str2float(line[1])
    let ny = ySf * str2float(line[2])
    let nz = zSf * str2float(line[3])

    " dump line with new coord.
    let newline = printf("%10s%1s%15.8f%1s%15.8f%1s%15.8f", nid, ',', nx, ',', ny, ',', nz)
    call setline(lnum, newline)

  endfor

  " restore cursor position
  call cursor(a:line1, 0)

endfunction

"-------------------------------------------------------------------------------

function! abq_node#Reflect(line1, line2, ...)

  "-----------------------------------------------------------------------------
  " Function to reflect node coordinates respect to user plane.
  "
  " Arguments:
  " - a:line1  : first line of selection
  " - a:line2  : last line of selection
  " - a:1      : plane description
  " - a:2      : plane point (default 0.0)
  " Return:
  " - None
  "-----------------------------------------------------------------------------

  " get command arguments
  if a:0 == 1
    let dir = tolower(a:1)
    let origin = 0.0
  elseif a:0 == 2
    let dir = tolower(a:1)
    let origin = str2float(a:2)
  endif

  " lines loop
  for lnum in range(a:line1, a:line2)

    " get a line
    let sline = getline(lnum)

    " skip comment/keyword lines
    if sline =~? '^\*'
      continue
    endif

    " split current line
    let line = split(sline, ',')

    " get node coordinates from line
    let nid = line[0]
    let nx = str2float(line[1])
    let ny = str2float(line[2])
    let nz = str2float(line[3])

    " reflect node coord.
    if dir == "x" || dir == "yz" || dir "zy"
      let nx = origin - (nx - origin)
    elseif dir == "y" || dir == "xz" || dir == "zx"
      let ny = origin - (ny - origin)
    elseif dir == "z" || dir == "xy" || dir == "yz"
      let nz = origin - (nz - origin)
    endif

    " dump line with new coord.
    let newline = printf("%10s%1s%15.8f%1s%15.8f%1s%15.8f", nid, ',', nx, ',', ny, ',', nz)
    call setline(lnum, newline)

  endfor

  " restore cursor position
  call cursor(a:line1, 0)

endfunction

"-------------------------------------EOF---------------------------------------
