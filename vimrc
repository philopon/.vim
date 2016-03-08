let vimbase = expand('~/.vim')

" {{{ dein
let s:dein_dir = vimbase.'/.dein'
let s:dein_repo_dir = s:dein_dir.'/repos/github.com/Shougo/dein.vim'
let s:dein_toml_path = vimbase.'/plugins.toml'

let g:dein#enable_name_conversion = 1

if &compatible
    set nocompatible
endif

if &runtimepath !~ '/dein.vim'
    if !isdirectory(s:dein_repo_dir)
        execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
    endif

    execute 'set runtimepath^='.fnamemodify(s:dein_repo_dir, ':p')
endif

call dein#begin(s:dein_dir)

if dein#load_cache([expand('<sfile>'), s:dein_toml_path])
    call dein#local("~/.vim/local", {"lazy": 1})
    call dein#load_toml(s:dein_toml_path)
    call dein#save_cache()
endif

augroup DeinHooks
    autocmd!
augroup END

for rc in split(globpath(vimbase.'/config', '**.vim'))
    exec 'source '.rc
endfor

for rc in split(globpath(vimbase.'/rc', '**.vim'))
    let name = fnamemodify(rc, ':t:r')
    if dein#tap(name)
        execute 'source '.rc
    endif
endfor

call dein#end()

if dein#check_install()
    call dein#install()
endif

filetype plugin indent on
syntax on
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
        call dein#update()
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
