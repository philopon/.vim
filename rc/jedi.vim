function! s:on_source()
    let libpython = system('python -c ''import sysconfig, glob, os;'.
                \ 'libdir = sysconfig.get_config_var("LIBDIR");'.
                \ 'print(glob.glob(os.path.join(libdir, "libpython?.?.*"))[0])''')

    exec 'set pythondll='.libpython

    let g:jedi#force_py_version =
                \ str2nr(system('python -c "import sys; print(sys.version_info.major)"'))

    if $CONDA_ENV_PATH != ''
        let script = 'import os, sys, glob;'.
                    \ 'conda_path, = glob.glob(os.path.join(os.environ["CONDA_ENV_PATH"], "lib", "python?.?", "site-packages"));'.
                    \ 'conda_path not in sys.path and '.
                    \ 'sys.path.insert(0, conda_path)'

        if g:jedi#force_py_version == 3
            exec "python3 ".script
        else
            exec "python ".script
        endif
    endif

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
