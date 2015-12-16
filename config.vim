set directory=/tmp

let backupdir = vimbase.'backup/'
if !isdirectory(backupdir)
    call mkdir(backupdir)
endif
let &backupdir = backupdir

if has('persistent_undo')
    let undodir = vimbase.'undo/'
    if !isdirectory(undodir)
        call mkdir(undodir)
    endif
    let &undodir = undodir
endif

set undofile

set number cmdheight=1 visualbell noerrorbells background=dark

set list listchars=tab:▸\ ,eol:↲,extends:»

set clipboard=unnamed,unnamedplus

set shellslash

set textwidth=0

set wildmode=list:longest history=10000

set autoindent smartindent shiftwidth=4 tabstop=4 softtabstop=4 expandtab

if IsLoaded('molokai')
    colorscheme molokai
endif
