if has('nvim')
    let script = expand('<sfile>:h:h').'/install_plugin.py'
    let python = exepath('python')
    let result = system(python.' '.script.' '.vimcache.'/python-client-version '.(24 * 3600))
    if result != ''
        echo result
    endif

    if v:shell_error
        UpdateRemotePlugins
    endif
endif
