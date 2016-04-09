function! local#dein#vim_indent_guides#hook_add() abort
    augroup hook_add_indent_guides
        execute 'autocmd!'
        execute 'autocmd VimEnter * call dein#source("indent-guides")'
    augroup END
endfunction

function! local#dein#vim_indent_guides#hook_source() abort
    let g:indent_guides_enable_on_vim_startup = 1
    let g:indent_guides_default_mapping = 0
    let g:indent_guides_auto_colors = 0
    highlight IndentGuidesOdd  ctermbg=234 guibg=#252525
    highlight IndentGuidesEven ctermbg=235 guibg=#333333
endfunction
