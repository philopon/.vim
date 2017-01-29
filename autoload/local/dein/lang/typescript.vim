function! local#dein#lang#typescript#hook_add_tsuquyomi() abort
    augroup hook_add_tsuquyomi
        execute 'autocmd!'
        execute 'autocmd FileType typescript nmap <buffer> <silent> K :TsuReferences<CR>'
    augroup END
endfunction
