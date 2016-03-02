function! s:on_source()
    let g:indent_guides_enable_on_vim_startup = 1
    let g:indent_guides_default_mapping = 0
endfunction

function! s:on_post_source()
    let g:indent_guides_auto_colors = 0
    highlight IndentGuidesOdd  ctermbg=234 guibg=#252525
    highlight IndentGuidesEven ctermbg=235 guibg=#333333
    IndentGuidesEnable
endfunction

execute 'autocmd DeinHooks User' 'dein#source#'.g:dein#name 'call s:on_source()'
execute 'autocmd DeinHooks User' 'dein#post_source#'.g:dein#name 'call s:on_post_source()'

augroup indent_guide_loader
    autocmd VimEnter * call dein#source('indent-guides') | autocmd! indent_guide_loader
augroup END
