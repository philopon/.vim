function! local#dein#watchdogs#hook_add() abort
    augroup hook_add_vim_watchdogs
        execute 'autocmd!'
        execute 'autocmd BufWritePre * call dein#source("watchdogs") | autocmd! hook_add_vim_watchdogs'
    augroup END
endfunction

function! local#dein#watchdogs#hook_source() abort
    if !exists('g:quickrun_config')
        let g:quickrun_config = {}
    endif

    let g:quickrun_config['python/watchdogs_checker'] =
                \ {'runner/vimproc/updatetime': 10}

    if executable('flake8')
        let g:quickrun_config['python/watchdogs_checker'].type = 'watchdogs_checker/flake8'
    endif

    let g:quickrun_config['watchdogs_checker/tsc'] =
                \ { 'exec': '%c' }

    let g:watchdogs_check_BufWritePost_enable = 1
    let g:watchdogs_check_BufWritePost_enables = {"typescript": 0}
    let g:watchdogs_check_CursorHold_enable = 1
    let g:watchdogs_check_CursorHold_enables = g:watchdogs_check_BufWritePost_enables
endfunction
