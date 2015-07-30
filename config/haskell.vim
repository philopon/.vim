augroup HaskellConfig
  autocmd!
augroup END

if neobundle#is_installed('vim2hs')
  let g:haskell_conceal = 0
endif

if neobundle#is_installed('ghcmod-vim')

  let s:enable_liquid = 0

  function! s:toggle_liquid()
    if !exists('g:syntastic_haskell_checkers')
      echo "Use LiquidHaskell"
      let g:syntastic_haskell_checkers = ['liquid']
    else
      echo "Disable LiquidHaskell"
      unlet g:syntastic_haskell_checkers
    endif
  endfunction

  command! ToggleLiquid :call s:toggle_liquid()

  function! s:register_ghcmod()
    autocmd HaskellConfig BufWritePost,FileWritePost <buffer> GhcModCheckAsync
    nnoremap <buffer><silent> <Leader>t :<C-u>GhcModType<CR>
    nnoremap <buffer><silent> <Leader>l :<C-u>ToggleLiquid<CR>
  endfunction

  autocmd HaskellConfig FileType haskell,lhaskell,chaskell
        \ call s:register_ghcmod()
endif

if neobundle#is_installed('neco-ghc')
  autocmd HaskellConfig FileType haskell,lhaskell,chaskell
    \ setlocal omnifunc=necoghc#omnifunc
endif
