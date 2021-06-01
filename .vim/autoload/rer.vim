function! rer#foldhead()
  let linelen = &tw ? &tw : 80
  let header  = substitute(getline(v:foldstart), "^[^a-zA-Z0-9]*", '', '')
  let marker  = ' *' . strpart(&fmr, 0, stridx(&fmr, ',')) . '\d*'
  let range   = foldclosedend(v:foldstart) - foldclosed(v:foldstart) + 1

  let left    = repeat('..', v:foldlevel - 1) . substitute(header, marker, '', '')
  let leftlen = len(left)

  let right    = range . ' [' . v:foldlevel . ']'
  let rightlen = len(right)

  let short    = strpart(left, 0, linelen - rightlen - 1)
  let shortlen = len(short)

  if leftlen > (shortlen)
    let left    = strpart(short, 0, shortlen - 3) . '...'
    let leftlen = shortlen
    let fill    = ' '
  else
    let fill    = ' ' . repeat('-', linelen - (leftlen + rightlen)) . ' '
  endif

  return left . fill . right . repeat(' ', 100)
endfunction
