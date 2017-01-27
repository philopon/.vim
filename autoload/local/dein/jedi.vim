function! local#dein#jedi#hook_source() abort
    let g:jedi#force_py_version = str2nr(vimproc#system('python -c "import sys; print(sys.version_info.major)"'))

    if dein#tap('neocomplete') || dein#tap('deoplete')
        let g:jedi#show_call_signatures = 0
        let g:jedi#auto_vim_configuration = 0
        let g:jedi#completions_enabled = 0
        let g:jedi#popup_on_dot = 0

        if dein#tap('neocomplete')
            if !exists('g:neocomplete#sources#omni#input_patterns')
                let g:neocomplete#sources#omni#input_patterns = {}
            endif
            let g:neocomplete#sources#omni#input_patterns.python =
                        \ '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
        endif
    endif

    augroup hook_source_jedi
        execute 'autocmd!'
        execute 'autocmd FileType python setlocal omnifunc=jedi#completions completeopt-=preview'
    augroup END
endfunction
