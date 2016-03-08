function! s:on_source()
    if !exists('g:quickrun_config')
        let g:quickrun_config = {}
    endif

    let g:quickrun_config['python/watchdogs_checker'] =
                \ { 'type': 'watchdogs_checker/flake8'
                \ , 'runner/vimproc/updatetime': 10
                \ }

    let g:watchdogs_check_BufWritePost_enable = 1
    let g:watchdogs_check_CursorHold_enable = 1
endfunction

augroup load_vim_watchdogs
    autocmd!
    autocmd BufWritePre * call dein#source(['watchdogs'])
                \ | autocmd! load_vim_watchdogs
augroup END

execute 'autocmd DeinHooks User dein#source#'.g:dein#name.' call s:on_source()'
