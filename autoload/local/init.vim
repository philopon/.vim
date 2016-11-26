function! local#init#write_last_updated(file) abort
    let l:current = str2nr(strftime('%s'))
    call writefile([l:current], a:file)
endfunction

function! local#init#check_require_update(file, interval) abort
    if !filereadable(a:file)
        let l:last = 0
    else
        let l:last = str2nr(readfile(a:file)[0])
    endif

    let l:current = str2nr(strftime('%s'))

    return l:current - l:last > a:interval
endfunction

let s:last_updated_file = vimcache.'/last_updated'

function! local#init#dein_install(ci, interval) abort
    if a:ci
        call dein#install()
    elseif local#init#check_require_update(s:last_updated_file, a:interval)
        call dein#update()
    else
        return 1
    endif

    call local#init#write_last_updated(s:last_updated_file)
endfunction
