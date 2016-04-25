if has('nvim') && system('python -c "import neovim"') != ''
    if $VIRTUAL_ENV != ''
        echo system('pip install neovim')
    else
        echo system('pip install --user neovim')
    endif
    UpdateRemotePlugins
endif
