if has('nvim') && system(exepath('python').' -c "import neovim"') != ''
    let s:pip = exepath('pip')
    if $VIRTUAL_ENV != ''
        echo system(s:pip.' install neovim')
    else
        echo system(s:pip.'pip install --user neovim')
    endif
    UpdateRemotePlugins
endif
