auto FileType haskell setlocal shiftwidth=1

NeoBundle 'dag/vim2hs' "{{{
if neobundle#tap('vim2hs')
  let g:haskell_conceal = 0
endif
"}}}

NeoBundle 'eagletmt/ghcmod-vim' "{{{
if neobundle#tap('ghcmod-vim')
  function MyGhcModKeymap()
    noremap <buffer> <silent> [space]t :<C-u>GhcModType<CR>
  endfunction
  autocmd FileType haskell call MyGhcModKeymap()
endif
"}}}

NeoBundle 'ujihisa/neco-ghc'

NeoBundle 'ujihisa/unite-haskellimport'


