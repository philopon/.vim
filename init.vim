let vimbase = expand('~/.config/nvim')
execute 'set runtimepath+='.vimbase

let vimcache = expand('~/.cache/nvim')
if ! isdirectory(vimcache)
    call mkdir(vimcache, 'p')
endif

" {{{ dein
let s:dein_dir = vimcache.'/dein'
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
    call dein#local(vimbase."/local", {"lazy": 1})

    for toml in s:dein_tomls
        call dein#load_toml(toml, {'lazy': 1})
    endfor

    call dein#end()
    call dein#save_state()
endif

augroup DeinPackages
    autocmd!
    if dein#check_install()
        autocmd VimEnter * call local#init#first_install()
    else
        autocmd VimEnter * call local#init#update()
    endif
augroup END

filetype plugin indent on
syntax on
" }}}

" vim:set foldmethod=marker:
