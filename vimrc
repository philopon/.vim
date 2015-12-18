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

if neobundle#load_cache()
    call neobundle#load_toml(vimbase.'/plugins.toml')

    NeoBundleSaveCache
endif

autocmd BufWritePost plugins.toml NeoBundleClearCache

for rc in split(globpath(vimbase.'/rc', '**.vim'))
    exec "source ".rc
endfor

call neobundle#end()
syntax on
filetype plugin indent on
NeoBundleCheck
" }}}

" vim:set foldmethod=marker:
