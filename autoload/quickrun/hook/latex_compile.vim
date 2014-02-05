let s:save_cpo = &cpo
set cpo&vim

let s:latex_partial_markers = [
      \   ['^\s*\(\\\|% Fake\)subsubsection\>', 5],
      \   ['^\s*\(\\\|% Fake\)subsection\>',    4],
      \   ['^\s*\(\\\|% Fake\)section\>',       3],
      \   ['^\s*\(\\\|% Fake\)chapter\>',       2],
      \   ['^\s*\(\\\|% Fake\)part\>',          1],
      \ ]

function! s:get_preamble_and_section(linum) "{{{
  let l:result        = []
  let l:currentLines  = []
  let l:currentLevel  = -1
  let l:targetSection = 0
  let l:in_preamble   = 1
  let l:linum         = 0

  for line in getbufline('%', 1, '$')
    let l:linum += 1
    if line =~# '^\s*\\begin\s*{\s*document\s*}'
      call add(l:result, line)
      let l:in_preamble = 0
      continue
    endif

    if l:in_preamble
      call add(l:result, line)
      continue
    endif

    if line =~# '\s*\\end\s*{\s*document\s*}'
      if l:targetSection
        let l:result = extend(l:result, l:currentLines)
      else 
        let l:result = extend(l:result, repeat([''], len(l:currentLines)))
      endif
      call add(l:result, line)
      break
    endif

    for [part, level] in s:latex_partial_markers
      if line =~# part
        if level >  l:currentLevel
          let l:result = extend(l:result, repeat([''], len(l:currentLines)))
          let l:currentLines = []
        else " level <= l:currentLevel
          if l:targetSection
            let l:result = extend(l:result, l:currentLines)
            let l:targetSection = 0
          else 
            let l:result = extend(l:result, repeat([''], len(l:currentLines)))
          endif
          let l:currentLines = []
        endif
        let l:currentLevel = level
        break
      endif
    endfor

    if l:linum == a:linum
      let l:targetSection = 1
    endif

    call add(l:currentLines, line)

  endfor
  return l:result
endfunction "}}}

function s:modify_filepath_in_log(file, orig, mod) "{{{
  let content = readfile(a:file)
  let index = 0
  while index < len(content)
    let content[index] = substitute(content[index], a:mod, a:orig, 'g')
    let index += 1
  endwhile
  call writefile(content, a:file)
endfunction
"}}}

let s:hook = {
      \ 'config': {
      \   'enable':  0,
      \   'partial_enable': 0,
      \   'partial_suffix': '_partial'
      \   }
      \ }

function! s:hook.on_module_loaded(session, context)
  if self.config.partial_enable
    let self.config.original     = a:session.config.srcfile
    let a:session.config.srcfile = fnamemodify(a:session.config.srcfile, ':r') . self.config.partial_suffix . '.tex'
    call writefile(s:get_preamble_and_section(line('.')), a:session.config.srcfile)
  endif
endfunction

function! s:hook.on_success(session, context)
  echo 'Compile Success'
  cclose
endfunction

function! s:hook.on_failure(session, context)
  if self.config.partial_enable
    let logfile = fnamemodify(a:session.config.srcfile, ':r') . '.log'
    call s:modify_filepath_in_log(logfile, self.config.original, a:session.config.srcfile)
    cfile `=logfile`
  else
    cfile `=fnamemodify(a:session.config.srcfile, ':r') . '.log'`
  endif
  copen
endfunction

function! quickrun#hook#latex_compile#new()
  return deepcopy(s:hook)
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
