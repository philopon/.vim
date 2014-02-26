set cindent

""" Sync clipboard
set clipboard=unnamed,autoselect

""" enable backspace key in insert mode?
set backspace=2

set showcmd

set foldmethod=marker
set viewoptions=cursor,folds

set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set expandtab
set hidden

set wildmode=longest,list

if !isdirectory($HOME."/.vim/backup")
  call mkdir($HOME."/.vim/backup")
endif
set backupdir=$HOME/.vim/backup

if !isdirectory($HOME."/.vim/undo")
  call mkdir($HOME."/.vim/undo")
endif
set undodir=$HOME/.vim/undo
set undofile
set undolevels=2000

""" Keymap
imap <c-j> <esc>
nmap <c-j> <esc>
cmap <c-j> <esc>
vmap <c-j> <esc>
noremap ; :
noremap : ;
nmap zf zMzv
nmap zF zMzvzczO
nnoremap [space] <Nop>
nmap <Space>  [space]

""" color scheme
NeoBundle 'w0ng/vim-hybrid'
if neobundle#is_installed('vim-hybrid')
  let g:hybrid_use_Xresources = 1
  colorscheme hybrid
  autocmd GUIEnter * colorscheme hybrid
endif

set background=dark

syntax enable
filetype plugin indent on
