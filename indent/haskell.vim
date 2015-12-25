if exists('b:did_indent')
    finish
endif


setlocal autoindent
setlocal indentexpr=GetHaskellIndent()

setlocal indentkeys=!^F,o,O,0=where
setlocal expandtab

let b:undo_indent = 'setlocal '.join([
            \   'autoindent<',
            \   'expandtab<',
            \   'indentexpr<',
            \   'indentkeys<',
            \ ])

function! s:get_top_line(lnum)
    let lnum = a:lnum
    while lnum >= 0
        if getline(lnum) =~# '^\S'
            return lnum
        endif
        let lnum = lnum - 1
    endwhile
endfunction

function! s:get_where_level(lnum)
    let lnum = a:lnum
    while lnum >= 0
        let line = getline(lnum)
        if line =~# '\<where\>'
            return match(line, '\<where\>') * 2
        elseif line =~# '^\S'
            return 0
        endif
        let lnum = lnum - 1
    endwhile
endfunction

function! GetHaskellIndent()
    let current_line = getline(v:lnum)
    let before_indent = indent(v:lnum  - 1)

    if current_line =~# '^\s*where\>'
        return s:get_where_level(v:lnum - 1) + &l:shiftwidth / 2
    endif

    let before_line = getline(v:lnum - 1)

    if before_line =~# '^module\>.*\<where\>'
        return 0

    elseif before_line =~# '\(^module\>\|^data\>\|^type\>\|^class\>\|^instance\>'.
                        \ '\|\<case\>.*\<of\>\|\\case\>\|\<do\>\)'
        return before_indent + &l:shiftwidth

    elseif before_line =~# '\<if\>'
        return match(before_line, '\<if\>')

    elseif before_line =~# '\<where\>'
        let tlnum = s:get_top_line(v:lnum)
        if getline(tlnum) =~# '^module\>'
            return 0
        else
            return before_indent + &l:shiftwidth / 2
        endif
    endif

    return indent(v:lnum-1)
endfunction


let b:did_indent = 1
