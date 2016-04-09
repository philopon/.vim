function! local#dein#neco_ghc#hook_source() abort
    augroup hook_source_neco_ghc
        execute 'autocmd!'
        execute 'autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc'
    augroup END
endfunction
