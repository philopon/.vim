" neobundle prelude {{{
if !1 | finish | endif

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
" }}}

source ~/.vim/config/global.vim

" neobundle postlude {{{
call neobundle#end()
filetype plugin indent on
NeoBundleCheck
" }}}

" vim: filetype=vim foldmethod=marker
