function! local#dein#lang#haskell#hook_source_neco_ghc() abort
    augroup hook_source_neco_ghc
        execute 'autocmd!'
        execute 'autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc'
    augroup END
endfunction
