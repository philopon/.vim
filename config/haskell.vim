auto FileType haskell setlocal shiftwidth=1

NeoBundleLazy 'dag/vim2hs', { 'autoload' : { 'filetypes': ['haskell'] } } "{{{
if neobundle#tap('vim2hs')
  function! neobundle#tapped.hooks.on_source(bundle)
    let g:haskell_conceal = 0
  endfunction
  call neobundle#untap()
endif
"}}}

NeoBundleLazy 'eagletmt/ghcmod-vim', { 'autoload' : { 'filetypes': ['haskell'] } } "{{{
if neobundle#tap('ghcmod-vim')
  function! neobundle#tapped.hooks.on_source(bundle)
    augroup config_haskell
      autocmd!
      autocmd FileType haskell noremap <buffer> <silent> [space]t :<C-u>GhcModType<CR>
    augroup END
  endfunction
  call neobundle#untap()
endif
"}}}

NeoBundleLazy 'ujihisa/neco-ghc', { 'autoload' : { 'filetypes': ['haskell'] } }



