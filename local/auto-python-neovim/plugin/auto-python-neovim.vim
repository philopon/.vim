let s:base = expand('<sfile>:h:h')
let s:latest_version_file = vimcache.'/latest_python_neovim'

function! s:parse_version(v) abort
    let vn = 0
    for sv in map(split(substitute(a:v, '\n', '', ''), '\.', 'g'), 'str2nr(v:val)')
        let vn = vn * 100 + sv
    endfor

    return vn
endfunction

function! s:check_installed(python, latest, recached) abort
    if a:recached
        let l:version = system([a:python, '-c', 'import pkg_resources; print(pkg_resources.get_distribution("neovim").version)'])
        if v:shell_error
            return 0
        endif

        return s:parse_version(l:version) >= a:latest
    endif

    call system([a:python, '-c', '__import__("imp").find_module("neovim")'])
    return !v:shell_error
endfunction

function! s:fetch_latest_version() abort
    let latest = system(['python', s:base.'/get_latest_version.py'])
    if v:shell_error
        return -1
    endif

    return s:parse_version(latest)
endfunction

function! s:get_latest_version(cache, interval) abort
    if !filereadable(a:cache)
        call writefile(['0', '0'], a:cache)
    endif

    let l:current = str2nr(strftime('%s'))

    let [l:last, l:version] = map(readfile(a:cache), 'str2nr(v:val)')

    if l:current - l:last > a:interval
        let l:version = s:fetch_latest_version()
        call writefile([l:current, l:version], a:cache)
        return [1, l:version]
    endif

    return [0, l:version]
endfunction

function! s:update_python_neovim(suffix, user, latest, recahced) abort
    let python = exepath('python' . a:suffix)

    if !s:check_installed(python, a:latest, a:recahced)
        let pip = exepath('pip' . a:suffix)
        let cmd = [pip, 'install', 'neovim']
        if a:user
            call add(cmd, '--user')
        endif

        execute "!".join(cmd, ' ')
    endif
endfunction

if has('nvim')
    let [s:recahced, s:latest] = s:get_latest_version(vimcache.'/python-neovim', 24 * 3600)
    let s:user = $VIRTUAL_ENV == ''
    let s:result2 = s:update_python_neovim('2', s:user, s:latest, s:recahced)
    let s:result3 = s:update_python_neovim('3', s:user, s:latest, s:recahced)
    if s:result2 || s:result3
        UpdateRemotePlugins
    endif
endif
