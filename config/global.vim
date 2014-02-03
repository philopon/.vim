""" Sync clipboard
set clipboard=unnamed,autoselect

""" enable backspace key in insert mode?
set backspace=2

set showcmd

set foldmethod=marker

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
noremap ; :
noremap : ;
nnoremap [space] <Nop>
nnoremap [unite] <Nop>
nmap <Space>  [space]
nmap [space]u [unite]
nnoremap <silent> [space]f :<C-u>set foldenable!<CR>

""" color scheme
NeoBundle 'w0ng/vim-hybrid'
if neobundle#tap('vim-hybrid')
  let g:hybrid_use_Xresources = 1
  colorscheme hybrid
endif

filetype plugin indent on
