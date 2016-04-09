let vimbase = expand('~/.vim')

" {{{ dein
let s:dein_dir = vimbase.'/.dein'
let s:dein_repo_dir = s:dein_dir.'/repos/github.com/Shougo/dein.vim'
let s:dein_toml_base = vimbase.'/dein'

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

for rc in split(globpath(vimbase.'/config', '**.vim'))
    exec 'source '.rc
endfor

if dein#load_state(s:dein_dir)
    let s:dein_tomls = []
    for toml in split(globpath(s:dein_toml_base, '**.toml'))
        call add(s:dein_tomls, toml)
    endfor

    call dein#begin(s:dein_dir, [$MYVIMRC] + s:dein_tomls)

    call dein#add('Shougo/dein.vim', {'rtp': ''})
    call dein#local("~/.vim/local", {"lazy": 1})

    for toml in s:dein_tomls
        call dein#load_toml(toml, {'lazy': 1})
    endfor

    call dein#end()
    call dein#save_state()
endif

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
