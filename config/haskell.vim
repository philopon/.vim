augroup HaskellConfig
  autocmd!
augroup END

if neobundle#is_installed('vim2hs')
  let g:haskell_conceal = 0
endif

if neobundle#is_installed('ghcmod-vim')
  function! s:register_ghcmod()
    autocmd HaskellConfig BufWritePost,FileWritePost <buffer> GhcModCheckAsync
    nnoremap <buffer><silent> <Leader>t :<C-u>GhcModType<CR>
    nnoremap <buffer><silent> <Leader>l :<C-u>GhcModLint<CR>
  endfunction

  autocmd HaskellConfig FileType haskell,lhaskell,chaskell
        \ call s:register_ghcmod()
endif

if neobundle#is_installed('neco-ghc')
  autocmd HaskellConfig FileType haskell,lhaskell,chaskell
    \ setlocal omnifunc=necoghc#omnifunc
endif
