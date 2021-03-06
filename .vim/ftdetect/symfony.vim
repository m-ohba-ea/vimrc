" Figure out which type of hilighting to use for html.
fun! s:SelectHTML()
  let n = 1
  while n < 50 && n <= line("$")
    " check for jinja
    if getline(n) =~ '{{.*}}\|\({%-\?\s*\)\(#\s*\)\(end.*\|extends\|block\|macro\|set\|if\|for\|include\|trans\)\>'
      set ft=jinja
      return
    endif
    let n = n + 1
  endwhile
endfun
autocmd BufNewFile,BufRead *.html,*.htm,*.nunjucks,*.nunjs  call s:SelectHTML()
autocmd BufNewFile,BufRead *.twig,*.tpl set ft=symfony


setlocal shiftwidth=2 tabstop=2 softtabstop=2

