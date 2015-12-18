function! neobundle#hooks.on_source(bundle)
    let g:indent_guides_enable_on_vim_startup = 1
    let g:indent_guides_start_level = 1
    let g:indent_guides_default_mapping = 0
endfunction

function! neobundle#hooks.on_post_source(bundle)
    let g:indent_guides_auto_colors = 0
    highlight IndentGuidesOdd  ctermbg=234 guibg=#252525
    highlight IndentGuidesEven ctermbg=235 guibg=#333333
endfunction
