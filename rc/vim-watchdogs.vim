if !exists('g:quickrun_config')
    let g:quickrun_config = {}
endif

let g:quickrun_config['watchdogs_checker/_'] =
            \ { 'runner/vimproc/updatetime': 50,
            \   'hook/back_window/enable_exit': 1,
            \   'hook/back_window/priority_exit': 1
            \ }
