function! neobundle#hooks.on_source(bundle)
    let g:deoplete#enable_at_startup = 1
    let g:deoplete#enable_smart_case = 1

    inoremap <expr><C-h> deoplete#mappings#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> deoplete#mappings#smart_close_popup()."\<C-h>"
endfunction
