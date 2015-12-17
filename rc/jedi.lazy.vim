if IsInstalled('neocomplete.vim')
    let g:jedi#auto_initialization = 1
    let g:jedi#auto_vim_configuration = 0
    let g:jedi#completions_enabled = 0
    let g:jedi#popup_on_dot = 0

    if !exists('g:neocomplete#sources#omni#input_patterns')
        let g:neocomplete#sources#omni#input_patterns = {}
    endif
    let g:neocomplete#sources#omni#input_patterns.python =
                \ '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'

    augroup vimrc_jedi_vim
        autocmd!
        autocmd FileType python setlocal omnifunc=jedi#completions completeopt-=preview
    augroup END
endif
