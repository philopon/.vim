function! s:create_directory_if_not_exist(dir)
  let dir = expand(a:dir)
  if !isdirectory(dir)
    call mkdir(dir)
  endif
endfunction

call s:create_directory_if_not_exist("~/.vim/backup")
call s:create_directory_if_not_exist("~/.vim/undo")

set ambiwidth=double
set autoindent
set autoread
set background=dark
set backup backupcopy=yes backupdir=~/.vim/backup
set clipboard+=unnamed
set cmdheight=1
set expandtab
set hlsearch
set incsearch
set matchtime=0
set numberwidth=1 relativenumber
set smartcase
set shiftwidth=2 tabstop=2 softtabstop=2 expandtab
set undofile undodir=~/.vim/undo undolevels=10000
set wildmode=list:longest,full

nnoremap x "_x
nnoremap zf zMzv
nnoremap zF zMzvzczO
nnoremap <Space> <Nop>
let mapleader = ' '
