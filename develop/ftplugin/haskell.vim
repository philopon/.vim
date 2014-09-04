if exists("b:did_yaskell_ftplugin")
  finish
endif
let b:did_yaskell_ftplugin = 1

let s:cpo_save = &cpo
set cpo&vim

let b:undo_ftplugin = "setl com< cms< fo<"

"" foldtext {{{
let s:foldtext_prefix = '+-- '

function! s:padding(i)
  return repeat(' ', 2 - float2nr(log10(a:i))) . a:i
endfunction

function! s:yaskellFoldHeader(foldstart, foldend)
  let nlanguage = 0
  for i in range(a:foldstart, a:foldend)
    if getline(i) =~# 'LANGUAGE'
      let nlanguage += 1
    endfor
  endfor
  return s:foldtext_prefix . s:padding(nlanguage) . ' LANGUAGE pragmas '
endfunction

function! s:yaskellFoldImport(foldstart, foldend)
  let nimport = 0
  for i in range(a:foldstart, a:foldend)
    if getline(i) =~# '^import\>'
      let nimport += 1
    endfor
  endfor
  return s:foldtext_prefix . s:padding(nimport) . ' modules imported '
endfunction

function! YaskellFoldtext(foldstart, foldend)
  for i in synstack(a:foldstart, 1)
    let name = synIDattr(i, 'name')
    if name == 'hsHeader'
      return s:yaskellFoldHeader(a:foldstart, a:foldend)
    elseif name == 'hsImport'
      return s:yaskellFoldImport(a:foldstart, a:foldend)
    endif
  endfor

  let line  = substitute(getline(a:foldstart), '\C\s*\(where\|=\|$\).*', '', 'g')
  let line  = substitute(line, '\C\s\+', ' ', 'g')
  let lines = a:foldend - a:foldstart + 1
  return s:foldtext_prefix . s:padding(lines) . ' lines: ' . line . ' '
endfunction
"" foldtext }}}

setlocal foldmethod=syntax foldtext=YaskellFoldtext(v:foldstart,v:foldend)
setlocal comments=:--

function! YaskellDisplaySynStack(line, col)
  for i in synstack(a:line, a:col)
    echomsg synIDattr(i, 'name')
  endfor
endfunction


let &cpo = s:cpo_save
unlet s:cpo_save
