if neobundle#tap('deoplete.nvim')
    function! neobundle#hooks.on_source(bundle)
        let g:deoplete#enable_at_startup = 1
        let g:deoplete#enable_smart_case = 1

        if !exists('g:neocomplete#force_omni_input_patterns')
            let g:neocomplete#force_omni_input_patterns = {}
        endif

        inoremap <expr><C-h> deoplete#mappings#smart_close_popup()."\<C-h>"
        inoremap <expr><BS> deoplete#mappings#smart_close_popup()."\<C-h>"
    endfunction
    call neobundle#untap()
endif
