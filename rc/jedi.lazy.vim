if IsInstalled('neocomplete.vim')
    let g:jedi#auto_vim_configuration = 0
    let g:jedi#completions_enabled = 0
    let g:jedi#popup_on_dot = 0

    if !exists('g:neocomplete#force_omni_input_patterns')
        let g:neocomplete#force_omni_input_patterns = {}
    endif
    let g:neocomplete#force_omni_input_patterns.python =
                \ '\%(\S\.\|^\s*@\|^\s*import \|^\s*from \|^\s*from .\+import \)'

    augroup vimrc_jedi_vim
        autocmd!
        autocmd FileType python setlocal omnifunc=jedi#completions completeopt-=preview
    augroup END
endif
