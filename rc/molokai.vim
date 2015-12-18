let s:theme =  expand('<sfile>:t:r')

function! neobundle#hooks.on_post_source(bundle)
    exec 'colorscheme '.s:theme
endfunction
