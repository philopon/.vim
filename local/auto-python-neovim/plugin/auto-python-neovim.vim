if has('nvim') && system('python -c "import neovim"') != ''
    if $VIRTUAL_ENV != ''
        echo system('pip install neovim==0.1.5')
    else
        echo system('pip install --user neovim==0.1.5')
    endif
endif
