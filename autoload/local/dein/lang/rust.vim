function! local#dein#lang#rust#hook_source_racer_rust() abort
    augroup hook_source_racer_rust
        autocmd!
        autocmd FileType rust nmap <buffer> gd <Plug>(rust-def-split)
        autocmd FileType rust nmap <buffer> K <Plug>(rust-doc)
    augroup END
endfunction

function! local#dein#lang#rust#hook_source_rust() abort
    augroup hook_source_rust
        autocmd!
        autocmd Filetype rust nmap <silent> <buffer> <Leader>r <C-u>:RustRun<CR>
    augroup END
endfunction
