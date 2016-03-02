function! s:on_source()
    let g:deoplete#enable_at_startup = 1
    let g:deoplete#enable_smart_case = 1
endfunction

execute 'autocmd DeinHooks User dein#source#'.g:dein#name.' call s:on_source()'
