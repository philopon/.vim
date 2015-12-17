let vimbase = expand('~/.vim')

if exists('&pythondll')
    let &pythondll = glob(systemlist('python2-config --prefix')[0].'/lib/libpython*')
endif

" neobundle {{{
if empty(glob(vimbase.'/.bundle/neobundle.vim'))
    exec "silent !git clone --depth 1 https://github.com/Shougo/neobundle.vim ".vimbase."/.bundle/neobundle.vim"
endif

if 0 | endif

if has('vim_starting')
    if &compatible
        set compatible
    endif

    exec 'set runtimepath+='.vimbase.'/.bundle/neobundle.vim'
endif

call neobundle#begin(vimbase.'/.bundle/')

NeoBundle 'tomasr/molokai'

if neobundle#load_cache()
    NeoBundleFetch 'Shougo/neobundle.vim'

    call neobundle#load_toml(vimbase.'/plugins.toml', {'lazy': 1})

    NeoBundleSaveCache
endif


call neobundle#end()
filetype plugin indent on
NeoBundleCheck
" }}}

exec "source ".vimbase."/config.vim"
exec "source ".vimbase."/keymap.vim"

for rc in split(globpath(vimbase.'/rc', '**'))
    exec "source ".rc
endfor

" vim:set foldmethod=marker:
