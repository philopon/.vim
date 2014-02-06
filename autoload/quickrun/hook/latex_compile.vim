let s:save_cpo = &cpo
set cpo&vim

function! s:delete_unused_lines(lines)
  let l:result = a:lines
  let l:index = 0
  while l:index < len(a:lines)
    if l:result[l:index] !~# '%\s*\(r\|R\)equire\s*$'
      let l:result[l:index] = ''
    endif
    let l:index += 1
  endwhile
  return l:result
endfunction

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
  let l:linum         = 0
  let l:currentHeader = ""

  let l:preamble = []
  while l:linum <= line('$')
    let l:linum += 1
    let l:line = getline(l:linum)
    if l:line =~# '^\s*\\begin\s*{\s*document\s*}'
      call add(l:result, l:line)
      break
    endif
    call add(l:preamble, line)
  endwhile

  while l:linum <= line('$')
    let l:linum += 1
    let l:line = getline(l:linum)

    if l:line =~# '\s*\\end\s*{\s*document\s*}'
      if l:targetSection
        let l:currentHeader = l:currentLines[0]
        let l:result = extend(l:result, l:currentLines)
      else 
        let l:result = extend(l:result, s:delete_unused_lines(l:currentLines))
      endif
      call add(l:result, l:line)
      break
    endif

    for [l:part, l:level] in s:latex_partial_markers
      if l:line =~# l:part
        if l:level >  l:currentLevel
          let l:result = extend(l:result, s:delete_unused_lines(l:currentLines))
          let l:currentLines = []
        else " l:level <= l:currentLevel
          if l:targetSection
            let l:currentHeader = l:currentLines[0]
            let l:result = extend(l:result, l:currentLines)
            let l:targetSection = 0
          else 
            let l:result = extend(l:result, s:delete_unused_lines(l:currentLines))
          endif
          let l:currentLines = []
        endif
        let l:currentLevel = l:level
        break
      endif
    endfor

    if l:linum == a:linum
      let l:targetSection = 1
    endif

    call add(l:currentLines, l:line)

  endwhile

  let l:preamble_op = split(substitute(l:currentHeader, '.*%\s*\(p\|P\)reamble\s*:\s*', '', ''), ',')
  let l:linum = 0
  while l:linum < len(l:preamble_op)
    let l:preamble_op[l:linum] = substitute(substitute(l:preamble_op[l:linum],'^\s\+','',''),'\s\+$','','')
    let l:linum += 1
  endwhile

  let l:linum = 0
  while l:linum < len(l:preamble)
    if l:preamble[l:linum] =~# '%\s*\(i\|I\)gnore\s*$'
      let l:preamble[l:linum] = ''
    elseif l:preamble[l:linum] =~# '%\s*\(o\|O\)ptional[^%,]*$'
      let l:tag = substitute(l:preamble[l:linum], '.*%\s*\(o\|O\)ptional\s*:\s*', '', '')
      if index(l:preamble_op, l:tag) < 0
        let l:preamble[l:linum] = ''
      endif
    elseif l:preamble[l:linum] =~# '%\s*\(d\|D\)efault[^%,]*$'
      let l:tag = substitute(l:preamble[l:linum], '.*%\s*\(d\|D\)efault\s*:\s*', '', '')
      if index(l:preamble_op, '!' . l:tag) >= 0
        let l:preamble[l:linum] = ''
      endif
    endif
    let l:linum += 1
  endwhile

  return extend(l:preamble, l:result)
endfunction "}}}

function s:modify_filepath_in_log(file, orig, mod) "{{{
  let l:content = readfile(a:file)
  let l:index = 0
  while l:index < len(l:content)
    let l:content[l:index] = substitute(l:content[l:index], a:mod, a:orig, 'g')
    let l:index += 1
  endwhile
  call writefile(l:content, a:file)
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
  echomsg 'Compile Success'
  cclose
endfunction

function! s:hook.on_failure(session, context)
  if self.config.partial_enable
    let l:logfile = fnamemodify(a:session.config.srcfile, ':r') . '.log'
    call s:modify_filepath_in_log(l:logfile, self.config.original, a:session.config.srcfile)
    cfile `=l:logfile`
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
