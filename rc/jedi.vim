function! neobundle#hooks.on_source(bundle)
    let g:jedi#force_py_version =
                \ str2nr(system('python -c "import sys; print(sys.version_info.major)"'))

    if neobundle#is_installed('neocomplete') || neobundle#is_installed('deoplete')
        let g:jedi#show_call_signatures = 0
        let g:jedi#auto_vim_configuration = 0
        let g:jedi#completions_enabled = 0
        let g:jedi#popup_on_dot = 0

        if neobundle#is_installed('neocomplete')
            if !exists('g:neocomplete#sources#omni#input_patterns')
                let g:neocomplete#sources#omni#input_patterns = {}
            endif
            let g:neocomplete#sources#omni#input_patterns.python =
                        \ '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
        endif

        augroup vimrc_jedi_vim
            autocmd!
            autocmd FileType python setlocal omnifunc=jedi#completions completeopt-=preview
        augroup END
    endif
endfunction
