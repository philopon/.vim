function! neobundle#hooks.on_source(bundle)
    autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
endfunction
