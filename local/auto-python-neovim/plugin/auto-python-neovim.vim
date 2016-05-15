if has('nvim')
    let script = expand('<sfile>:h:h').'/install_plugin.py'
    let python = exepath('python')
    echo system(python.' '.script.' '.vimcache.'/python-client-version '.(24 * 3600))
    UpdateRemotePlugins
endif
