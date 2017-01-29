function! local#dein#neomake#make() abort
    let t = &filetype

    if t == 'rust'
        Neomake! cargo
    elseif t == 'typescript'
        return
    else
        Neomake
    endif
endfunction

function! local#dein#neomake#hook_source() abort
    let g:neomake_open_list = 2
    augroup hook_source_neomake
        autocmd!
        autocmd BufWritePost * call local#dein#neomake#make()
    augroup END
endfunction
