augroup config_haskell
  autocmd FileType Haskell setlocal softtabstop=4 shiftwidth=4 
augroup END

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

NeoBundle 'git@github.com:philopon/haskell-indent.vim.git'

