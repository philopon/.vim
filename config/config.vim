set directory=/tmp

set backup
let backupdir = vimcache.'/backup'
if !isdirectory(backupdir)
    call mkdir(backupdir)
endif
let &backupdir = backupdir

if has('persistent_undo')
    let undodir = vimcache.'/undo'
    if !isdirectory(undodir)
        call mkdir(undodir)
    endif
    let &undodir = undodir
endif

set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8

set spelllang=en,cjk

set undofile

set number cmdheight=1 visualbell noerrorbells background=dark

set list listchars=tab:▸\ ,eol:↲,extends:»

if !has('nvim') || (exists('$DISPLAY') && (executable('xsel') || executable('xclip') || executable('pbcopy')))
    set clipboard=unnamed,unnamedplus
endif

set scrolloff=3

set cursorline
augroup ConfigCursorLine
    autocmd! ColorScheme * highlight clear CursorLine
augroup END

set hidden

set shellslash

set textwidth=0

set wildmode=list:longest history=10000

set autoindent smartindent shiftwidth=4 tabstop=4 softtabstop=4 expandtab
