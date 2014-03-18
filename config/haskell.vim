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

NeoBundleLazy 'eagletmt/ghcmod-vim', { 'autoload' : { 'filetypes': ['haskell'] }, 'depends': 'Shougo/vimproc' } "{{{
if neobundle#tap('ghcmod-vim')
  function! neobundle#tapped.hooks.on_source(bundle)
    augroup config_haskell
      autocmd!
      autocmd FileType haskell noremap <buffer> <silent> [space]t :<C-u>GhcModType<CR>
      autocmd BufWritePost,FileWritePost *.hs GhcModCheckAsync
    augroup END
  endfunction
  call neobundle#untap()
endif
"}}}

" NeoBundleLazy 'ujihisa/neco-ghc', { 'autoload' : { 'filetypes': ['haskell'] } }

NeoBundleLazy 'git@github.com:philopon/haskell-indent.vim.git', { 'autoload' : { 'filetypes': ['haskell'] } }

NeoBundle 'git@github.com:philopon/hassistant.vim.git', { 'build' : { 'mac' : 'sh build.sh'} }

if exists('g:quickrun_config')
  let g:quickrun_config.haskell = { 'command': 'runsandbox' }
endif
