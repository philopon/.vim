if neobundle#tap('incsearch.vim')
    function! neobundle#hooks.on_source(bundle)
        let g:incsearch#auto_nohlsearch = 1
    endfunction

    function! neobundle#hooks.on_post_source(bundle)
        IncSearchNoreMap <c-n> <Over>(incsearch-next)
        IncSearchNoreMap <c-p> <Over>(incsearch-prev)
    endfunction

    map /  <Plug>(incsearch-forward)
    map ?  <Plug>(incsearch-backward)
    map g/ <Plug>(incsearch-stay)

    map n  <Plug>(incsearch-nohl-n)
    map N  <Plug>(incsearch-nohl-N)
    map *  <Plug>(incsearch-nohl-*)
    map #  <Plug>(incsearch-nohl-#)
    map g* <Plug>(incsearch-nohl-g*)
    map g# <Plug>(incsearch-nohl-g#)

    call neobundle#untap()
endif
