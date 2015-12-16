Plug 'junegunn/vim-plug'
Plug 'tomasr/molokai'

if !has('nvim')
    Plug 'Shougo/neocomplete.vim', { 'on': [], 'insert': 1 }
endif

Plug 'Shougo/unite.vim', { 'on': 'Unite' }

Plug 'Shougo/vimproc.vim', { 'do': 'make', 'on': [] }
Plug 'thinca/vim-quickrun', { 'on': 'QuickRun', 'depends': ['vimproc.vim'] }
Plug 'osyo-manga/shabadou.vim', { 'on': [], 'depends': ['vim-quickrun'] }
Plug 'osyo-manga/vim-watchdogs',
            \ { 'on': ['WatchdogsRun', 'WatchdogsRunSilent', 'WatchdogsRunSweep'],
            \   'depends': ['shabadou.vim', 'vim-quickrun', 'vimproc.vim'] }

Plug '~/.vim/local/jedi-wrapper', { 'for': 'python' }
Plug 'davidhalter/jedi-vim', { 'on': [] }
Plug 'hynek/vim-python-pep8-indent', { 'for': 'python' }
