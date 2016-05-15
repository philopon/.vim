let s:last_updated_file = vimcache.'/last_updated'

function! local#init#write_last_updated() abort
    let l:current = str2nr(strftime('%s'))
    call writefile([l:current], s:last_updated_file)
endfunction


function! local#init#first_install() abort
    call dein#install()
    call local#init#write_last_updated()
endfunction


function! local#init#update() abort
    if !filereadable(s:last_updated_file)
        call writefile([0], s:last_updated_file)
    endif

    let l:last = str2nr(readfile(s:last_updated_file)[0])
    let l:current = str2nr(strftime('%s'))

    if l:current > l:last + 24 * 3600
        call dein#update()
        call local#init#write_last_updated()
    endif
endfunction
