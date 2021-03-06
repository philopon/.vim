function! local#dein#lang#tex#hook_source_vimtex() abort
    let g:vimtex_fold_enabled = 1
    let g:vimtex_imaps_enabled = 0

    if has('mac')
        function! UpdateSkim(status)
            if !a:status | return | endif

            let l:out = b:vimtex.out()
            let l:cmd = [g:vimtex_view_general_viewer, '-r']
            if !empty(system('pgrep Skim'))
                call extend(l:cmd, ['-g'])
            endif
            if has('nvim')
                call jobstart(l:cmd + [line('.'), l:out])
            elseif has('job')
                call job_start(l:cmd + [line('.'), l:out])
            else
                call system(join(l:cmd + [line('.'), shellescape(l:out)], ' '))
            endif
        endfunction

        let g:vimtex_view_general_viewer = 'displayline'
        let g:vimtex_view_general_options = '@line @pdf @tex'
        let g:vimtex_latexmk_callback_hook = 'UpdateSkim'
    endif
endfunction
