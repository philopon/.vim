function local#dein#vimproc#hook_add() abort
    if dein#util#_is_windows()
        let cmd = 'tools\\update-dll-mingw'
    elseif dein#util#_is_cygwin()
        let cmd = 'make -f make_cygwin.mak'
    elseif dein#util#_is_mac()
        let cmd = 'make -f make_mac.mak'
    else
        let cmd = 'make -f make_unix.mak'
    endif

    let g:dein#plugin.build = cmd
endfunction
