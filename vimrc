source $HOME/.vim/config/global.vim

""" NeoBundle
if has('vim_starting')
  set nocompatible
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle'))

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'thinca/vim-quickrun' "{{{
if neobundle#tap('vim-quickrun')
  nnoremap [space]r :<C-u>QuickRun -args 
  nnoremap <silent> [space]o :<C-u>only<CR>
endif
"}}}

NeoBundle 'Shougo/vimproc'

NeoBundle 'Shougo/unite.vim' "{{{
if neobundle#tap('unite.vim')
  let g:unite_enable_start_insert=1
  nnoremap <silent> [unite]f :<C-u>Unite file file/new<CR>
  nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
endif
"}}}

NeoBundle 'osyo-manga/unite-quickfix'

NeoBundle 'osyo-manga/vim-watchdogs'

NeoBundle 'scrooloose/syntastic' "{{{
if neobundle#tap('syntastic')
  let g:syntastic_always_populate_loc_list=1
endif
"}}}

NeoBundle 'sjl/gundo.vim' "{{{
if neobundle#tap('gundo')
  nnoremap [space]g :<C-u>GundoToggle<CR>
endif
"}}}

source $HOME/.vim/config/neocomplete.vim
source $HOME/.vim/config/haskell.vim
source $HOME/.vim/config/python.vim

if has('macunix')
  source $HOME/.vim/config/macunix.vim
endif

filetype plugin indent on

NeoBundleCheck

