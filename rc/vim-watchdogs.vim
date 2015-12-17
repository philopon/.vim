if !exists('g:quickrun_config')
    let g:quickrun_config = {}
endif

let g:quickrun_config['watchdogs_checker/_'] =
            \ { 'runner/vimproc/updatetime': 50,
            \   'hook/copen/enable_exist_data' : 1,
            \   'hook/back_window/enable_exit': 1,
            \   'hook/back_window/priority_exit': 1
            \ }

let g:quickrun_config['python/watchdogs_checker'] =
            \ { 'type': 'watchdogs_checker/flake8' }

" call watchdogs#setup(g:quickrun_config)

let g:watchdogs_check_BufWritePost_enable = 1
let g:watchdogs_check_CursorHold_enable = 1
