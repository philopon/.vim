if neobundle#tap('molokai')
    function! neobundle#hooks.on_post_source(bundle)
        colorscheme molokai
    endfunction
    call neobundle#untap()
endif
