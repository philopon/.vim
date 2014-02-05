let s:save_cpo = &cpo
set cpo&vim

let s:hook = {
      \ 'config': {
      \   'enable': 0
      \   }
      \ }

function! s:hook.on_success(session, context)
  echo 'Compile Success'
  cclose
endfunction

function! s:hook.on_failure(session, context)
  cfile `=fnamemodify(a:session.config.srcfile, ':r') . '.log'`
  copen
endfunction

function! quickrun#hook#show_latex_error#new()
  return deepcopy(s:hook)
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
