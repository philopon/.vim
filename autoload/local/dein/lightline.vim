function! local#dein#lightline#hook_add() abort
    set laststatus=2
    set ambiwidth=single

    if !has('gui_running')
        set t_Co=256
    endif

    let g:lightline = {}
    let g:lightline.colorscheme = 'wombat'

    let g:lightline.active = {}
    let g:lightline.active.left =
                \ [ ['mode', 'paste']
                \ , ['readonly', 'relativepath', 'modified']
                \ ]
    let g:lightline.active.right =
                \ [ ['lineinfo']
                \ , ['fileencoding', 'filetype']
                \ ]
endfunction
