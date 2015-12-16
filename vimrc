let vimbase = expand('~/.vim')

if exists('&pythondll')
    let &pythondll = glob(systemlist('python2-config --prefix')[0].'/lib/libpython*')
endif

" vim-plug {{{
if empty(glob(vimbase.'/.plugged/vim-plug/plug.vim'))
    exec "silent !git clone --depth 1 https://github.com/junegunn/vim-plug.git ".vimbase."/.plugged/vim-plug"
endif
call plug#begin(vimbase.'/.plugged')

exec "source ".vimbase."/plugins.vim"

call plug#end()
delcommand PlugUpgrade

let g:plug_window='new'

" https://github.com/junegunn/vim-plug/issues/212
function! s:install_plugins(names)
    if confirm('install?: '.string(a:names), "&Yes\n&No", 0) == 1
        PlugInstall
    endif
endfunction

let s:to_install = filter(copy(g:plugs), '!isdirectory(v:val.dir)')
if !empty(s:to_install)
    augroup install_plugins
        autocmd!
        autocmd VimEnter * call s:install_plugins(keys(s:to_install))
                    \ | source $MYVIMRC | autocmd! install_plugins
    augroup END
endif

" https://github.com/junegunn/vim-plug/issues/146
function! IsInstalled(name)
    let pkg = get(g:plugs, a:name, {})
    if has_key(pkg, 'dir')
        return isdirectory(pkg.dir)
    endif
    echomsg 'IsInstalled: unknown package: '.a:name
endfunction

function! IsLoaded(name)
    let pkg = get(g:plugs, a:name, {})
    if has_key(pkg, 'dir')
        return isdirectory(pkg.dir) && stridx(&rtp, pkg.dir) >= 0
    endif
    echomsg 'IsLoaded: unknown package: '.a:name
endfunction
" }}}

" {{{ autoload
for [name, pkg] in items(g:plugs)
    if !IsInstalled(name)
        continue
    endif

    let base = vimbase.'/rc/'

    let conf_name = substitute(name, '[.\-_]n\?vim', '', '')
    let rc = base.conf_name.'.vim'
    let lazy = base.conf_name.'.lazy.vim'

    if filereadable(rc)
        exec "source ".rc
    endif

    " dependency loader
    if has_key(pkg, 'depends')
        if !IsLoaded(name)
            execute 'autocmd! User '.name.
                        \ ' call call("plug#load",'.string(pkg.depends).')'
        else
            call call('plug#load', pkg.depends)
        endif
    endif

    if filereadable(lazy)
        " lazy load
        if has_key(pkg, 'for') || (has_key(pkg, 'on') && !empty(pkg.on))
            exec "autocmd! User ".name." source ".lazy
        " lazy insert load
        elseif get(pkg, 'insert', 0)
            execute 'augroup load_'.conf_name
                autocmd!
                execute 'autocmd InsertEnter * call plug#load('''.name.''') '
                            \ .'| source '.lazy.' | autocmd! load_'.conf_name
            execute 'augroup END'
        endif
    endif
endfor
" }}}

exec "source ".vimbase."/config.vim"
exec "source ".vimbase."/keymap.vim"

" vim:set foldmethod=marker:
