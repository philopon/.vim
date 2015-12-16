Plug 'junegunn/vim-plug'
Plug 'tomasr/molokai'

if !has('nvim')
    Plug 'Shougo/neocomplete.vim', { 'on': [], 'insert': 1 }
endif


Plug 'Shougo/unite.vim', { 'on': 'Unite' }

Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'thinca/vim-quickrun', { 'on': 'QuickRun' }
Plug 'osyo-manga/shabadou.vim', { 'on': [] }
Plug 'osyo-manga/vim-watchdogs', { 'on': ['WatchdogsRun', 'WatchdogsRunSilent', 'WatchdogsRunSweep'], 'depends': ['shabadou.vim', 'vim-quickrun'] }

Plug 'davidhalter/jedi-vim', { 'for': 'python' }
Plug 'hynek/vim-python-pep8-indent', { 'for': 'python' }
