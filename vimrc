" neobundle prelude {{{
if !1 | finish | endif

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
" }}}

" packages {{{

"" misc {{{
NeoBundle 'w0ng/vim-hybrid'

NeoBundle 'Shougo/vimproc.vim', {
      \ 'build' : {
      \     'windows' : 'tools\\update-dll-mingw',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'linux' : 'make',
      \     'unix' : 'gmake',
      \    },
      \ }

NeoBundle 'Shougo/vimshell.vim'
NeoBundle 'Shougo/vimfiler.vim'

NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/unite.vim'

NeoBundle 'Lokaltog/vim-easymotion'

NeoBundle 'tpope/vim-fugitive'
NeoBundle 'airblade/vim-gitgutter'

NeoBundle 'itchyny/lightline.vim'
NeoBundle 'cocopon/lightline-hybrid.vim'

NeoBundle 'tyru/open-browser.vim'

NeoBundle 'thinca/vim-quickrun'
"" }}}

"" Haskell {{{
let s:autoload_haskell = "{'autoload': {'filetypes': ['haskell', 'lhaskell', 'chaskell']}}"
execute "NeoBundleLazy 'dag/vim2hs'," . s:autoload_haskell
execute "NeoBundleLazy 'eagletmt/ghcmod-vim'," . s:autoload_haskell
execute "NeoBundleLazy 'eagletmt/neco-ghc'," . s:autoload_haskell
execute "NeoBundleLazy 'git@github.com:philopon/haskell-indent.vim.git'," . s:autoload_haskell
"" }}}

NeoBundleLazy 'plasticboy/vim-markdown', {'autoload': {'filetypes': ['mkd']}}
NeoBundleLazy 'kannokanno/previm', {'autoload': {'filetypes': ['mkd']}}

NeoBundleLazy 'lambdatoast/elm.vim', {'autoload': {'filetypes': ['elm']}}

NeoBundleLazy 'raichoo/purescript-vim', {'autoload': {'filetypes': ['purescript']}}
" }}}

source ~/.vim/config/global.vim
source ~/.vim/config/misc.vim
source ~/.vim/config/haskell.vim
source ~/.vim/config/elm.vim
source ~/.vim/config/purescript.vim

" neobundle postlude {{{
call neobundle#end()
filetype plugin indent on
NeoBundleCheck
" }}}

source ~/.vim/config/colorscheme.vim

" vim: filetype=vim foldmethod=marker
