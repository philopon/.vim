if neobundle#tap('ctrlp.vim')
    function! neobundle#hooks.on_source(bundle)
        let g:ctrlp_working_path_mode = 'ra'
    endfunction
    call neobundle#untap()
endif
