if exists("b:did_indent")
  finish
endif
runtime! indent/html.vim

unlet! b:did_indent

if &l:indentexpr == ''
  if &l:cindent
    let &l:indentexpr = 'cindent(v:lnum)'
  else
    let &l:indentexpr = 'indent(prevnonblank(v:lnum-1))'
  endif
endif
let b:html_indentexpr = &l:indentexpr

setlocal shiftwidth=2 tabstop=2 softtabstop=2

let b:did_indent = 1

setlocal indentexpr=GetSymfonyIndent()
setlocal indentkeys=o,O,*<Return>,{,},o,O,!^F,<>>

" Only define the function once.
if exists("*GetSymfonyIndent")
  finish
endif

function! GetSymfonyIndent(...)
  if a:0 && a:1 == '.'
    let v:lnum = line('.')
  elseif a:0 && a:1 =~ '^\d'
    let v:lnum = a:1
  endif
  let vcol = col('.')

  call cursor(v:lnum,vcol)

  exe "let ind = ".b:html_indentexpr

  let lnum = prevnonblank(v:lnum-1)
  let pnb = getline(lnum)
  let cur = getline(v:lnum)

  let tagstart = '.*' . '{%\s*'
  let tagend = '.*%}' . '.*'

  let tagstart2 = '.*' . '#\s*'
  let tagend2 = '.*' . '#\s*'

  let blocktags = '\(for\|if\)'
  let midtags = '\(else\|elif\)'

  let pnb_blockstart = pnb =~# tagstart . blocktags . tagend
  let pnb_blockend   = pnb =~# tagstart . 'end' . blocktags . tagend
  let pnb_blockmid   = pnb =~# tagstart . midtags . tagend

  let pnb_blockstart2 = pnb =~# tagstart2 . blocktags . tagend2
  let pnb_blockend2   = pnb =~# tagstart2 . 'end' . blocktags . tagend2
  let pnb_blockmid2   = pnb =~# tagstart2 . midtags . tagend2

  let cur_blockstart = cur =~# tagstart . blocktags . tagend
  let cur_blockend   = cur =~# tagstart . 'end' . blocktags . tagend
  let cur_blockmid   = cur =~# tagstart . midtags . tagend

  let cur_blockstart2 = cur =~# tagstart2 . blocktags . tagend2
  let cur_blockend2   = cur =~# tagstart2 . 'end' . blocktags . tagend2
  let cur_blockmid2   = cur =~# tagstart2 . midtags . tagend2

  if pnb_blockstart && !pnb_blockend
    let ind = ind + &sw
  elseif pnb_blockmid && !pnb_blockend
    let ind = ind + &sw
  endif

  if cur_blockend && !cur_blockstart
    let ind = ind - &sw
  elseif cur_blockmid
    let ind = ind - &sw
  endif

  if pnb_blockstart2 && !pnb_blockend2
    let ind = ind + &sw
  elseif pnb_blockmid2 && !pnb_blockend2
    let ind = ind + &sw
  endif

  if cur_blockend2 && !cur_blockstart2
    let ind = ind - &sw
  elseif cur_blockmid2
    let ind = ind - &sw
  endif

  return ind
endfunction

