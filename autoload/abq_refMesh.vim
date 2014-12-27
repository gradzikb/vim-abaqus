"-------------------------------------BOF---------------------------------------
"
" Vim filetype plugin file
"
" Language:     VIM Script
" Filetype:     Abaqus FE solver input file
" Maintainer:   Bartosz Gradzik <bartosz.gradzik@hotmail.com>
" Last Change:  26th of December 2014
"
"-------------------------------------------------------------------------------
"
" v1.0.0
"   - initial version
"
"-------------------------------------------------------------------------------

function! abq_refMesh#RefMesh(line1, line2)

  "-----------------------------------------------------------------------------
  " Function to read Abaqus reference mesh.
  "
  " Arguments:
  " - none
  " Return:
  " - none
  "-----------------------------------------------------------------------------

  " node id start range number
  let nodeIdStart = 1

  " grap reference mesh
  let meshTria = {}
  let meshQuad = {}
  for lnum in range(a:line1, a:line2, 2)

    " read lines
    let line1 = split(getline(lnum), '\s*,\s*')
    let line2 = split(getline(lnum+1), '\s*,\s*')

    " remove white signs
    call map(line1, 'substitute(v:val, "\\s", "", "g" )')
    call map(line2, 'substitute(v:val, "\\s", "", "g" )')

    " tria or quad?
    if len(line2) == 6
      let elType = 'quad'
    else
      let elType = 'tria'
    endif

    " define node ids
    let n1 = nodeIdStart
    let n2 = nodeIdStart + 1
    let n3 = nodeIdStart + 2
    if elType == 'quad'
      let n4 = nodeIdStart + 3
    endif

    " tria elements
    let elId = (line1[0])
    if elType == 'tria'
    let meshTria[elId] = {}
      let meshTria[elId][n1] = [line1[1], line1[2], line1[3]]
      let meshTria[elId][n2] = [line1[4], line1[5], line1[6]]
      let meshTria[elId][n3] = [line2[0], line2[1], line2[2]]
    " quad elements
    elseif elType == 'quad'
      let meshQuad[elId] = {}
      let meshQuad[elId][n1] = [line1[1], line1[2], line1[3]]
      let meshQuad[elId][n2] = [line1[4], line1[5], line1[6]]
      let meshQuad[elId][n3] = [line2[0], line2[1], line2[2]]
      let meshQuad[elId][n4] = [line2[3], line2[4], line2[5]]
    endif

    " increment node id start
    if elType == 'tria'
      let nodeIdStart = n3 + 1
    elseif elType == 'quad'
      let nodeIdStart = n4 + 1
    endif

  endfor

  " open new window with empty buffer
  vnew

  " write comment line
  normal! o
  call setline('.', '**')

  " dump nodes
  normal! o
  call setline('.', '*NODE')
  for e in keys(meshTria)
    for n in keys(meshTria[e])
      let nx = meshTria[e][n][0]
      let ny = meshTria[e][n][1]
      let nz = meshTria[e][n][2]
      let ldump = printf("%10s, %16s, %16s, %16s", n, nx, ny, nz)
      normal! o
      call setline('.',ldump)
    endfor
  endfor
  for e in keys(meshQuad)
    for n in keys(meshQuad[e])
      let nx = meshQuad[e][n][0]
      let ny = meshQuad[e][n][1]
      let nz = meshQuad[e][n][2]
      let ldump = printf("%10s, %16s, %16s, %16s", n, nx, ny, nz)
      normal! o
      call setline('.',ldump)
    endfor
  endfor

  " write comment line
  normal! o
  call setline('.', '**')

  " dump tria elements
  if len(meshTria) != 0
    normal! o
    call setline('.', '*ELEMENT, TYPE=M3D3, ELSET=abqRefMesh')
    for e in sort(keys(meshTria))
      let nodes = sort(keys(meshTria[e]))
      let n1 = nodes[0]
      let n2 = nodes[1]
      let n3 = nodes[2]
      let ldump = printf("%10s, %10s, %10s, %10s", e, n1, n2, n3)
      normal! o
      call setline('.',ldump)
    endfor
  endif

  " dump quad elements
  if len(meshQuad) != 0
    normal! o
    call setline('.', '*ELEMENT, TYPE=M3D4R, ELSET=abqRefMesh')
    for e in sort(keys(meshQuad))
      let nodes = sort(keys(meshQuad[e]))
      let n1 = nodes[0]
      let n2 = nodes[1]
      let n3 = nodes[2]
      let n4 = nodes[3]
      let ldump = printf("%10s, %10s, %10s, %10s, %10s", e, n1, n2, n3, n4)
      normal! o
      call setline('.',ldump)
    endfor
  endif

  " write comment line
  normal! o
  call setline('.', '**')

  " remove first line in the file
  normal! ggdd

endfunction

"-------------------------------------EOF---------------------------------------
