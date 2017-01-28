function! local#dein#racer_rust#hook_source() abort
    augroup hook_source_racer_rust
        autocmd!
        autocmd FileType rust nmap <buffer> gd <Plug>(rust-def-split)
        autocmd FileType rust nmap <buffer> K <Plug>(rust-doc)
    augroup END
endfunction
