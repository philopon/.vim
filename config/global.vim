""" Sync clipboard
set clipboard=unnamed,autoselect

""" enable backspace key in insert mode?
set backspace=2

set showcmd

"set nofoldenable
set foldmethod=marker

set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set expandtab
set hidden

if !isdirectory($HOME."/.vim/backup")
  call mkdir($HOME."/.vim/backup")
endif
set backupdir=$HOME/.vim/backup

if !isdirectory($HOME."/.vim/undo")
  call mkdir($HOME."/.vim/undo")
endif
set undodir=$HOME/.vim/undo
set undofile

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


