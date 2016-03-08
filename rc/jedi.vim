function! s:on_source()
    let g:jedi#force_py_version =
                \ str2nr(system('python -c "import sys; print(sys.version_info.major)"'))

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

        augroup vimrc_jedi_vim
            autocmd!
            autocmd FileType python setlocal omnifunc=jedi#completions completeopt-=preview
        augroup END
    endif
endfunction

execute 'autocmd DeinHooks User dein#source#'.g:dein#name.' call s:on_source()'
