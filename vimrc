let vimbase = expand('~/.vim')

if exists('&pythondll')
    let &pythondll = glob(systemlist('python2-config --prefix')[0].'/lib/libpython*')
endif

" neobundle {{{
if empty(glob(vimbase.'/.bundle/neobundle.vim'))
    exec "silent !git clone --depth 1 https://github.com/Shougo/neobundle.vim ".
                \ vimbase."/.bundle/neobundle.vim"
endif

let g:neobundle#enable_name_conversion = 1

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

augroup clear_cache_on_save
    autocmd!
    autocmd BufWritePost plugins.toml NeoBundleClearCache
augroup END

for rc in split(globpath(vimbase.'/config', '**.vim'))
    exec 'source '.rc
endfor

for rc in split(globpath(vimbase.'/rc', '**.vim'))
    let name = fnamemodify(rc, ':t:r')
    if neobundle#tap(name)
        exec 'source '.rc
        call neobundle#untap()
    endif
endfor

call neobundle#end()
filetype plugin indent on
NeoBundleCheck
" }}}

"{{{ check updates
let s:upd_name = vimbase.'/.last_updated'

if !filereadable(s:upd_name)
    call writefile([0], s:upd_name)
endif

let s:last = str2nr(readfile(s:upd_name)[0])
let s:current = str2nr(strftime('%s'))

if s:current > s:last + 24 * 3600
    function! s:check_updates()
        NeoBundleCheckUpdate
        call writefile([s:current], s:upd_name)
        autocmd! auto_check_updates
    endfunction

    augroup auto_check_updates
        autocmd!
        autocmd VimEnter * call s:check_updates()
    augroup END
endif
"}}}

" vim:set foldmethod=marker:
