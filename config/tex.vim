NeoBundle 'LaTeX-Box-Team/LaTeX-Box' "{{{
if neobundle#tap('LaTeX-Box')
  let g:LatexBox_no_mappings = 1
  let g:LatexBox_output_type = 'dvi'
  let g:LatexBox_viewer = 'open -a Skim'

  augroup latex_box_keymap
    autocmd!
    autocmd FileType tex imap <buffer> [[     \begin{
    autocmd FileType tex imap <buffer> ]]     <Plug>LatexCloseCurEnv
    autocmd FileType tex nmap <buffer> [space]ec   <Plug>LatexChangeEnv
    autocmd FileType tex nmap <buffer> [space]es   <Plug>LatexToggleStarEnv
    autocmd FileType tex vmap <buffer> <F7>   <Plug>LatexWrapSelection
    autocmd FileType tex vmap <buffer> <S-F7> <Plug>LatexEnvWrapSelection
  augroup END
endif
"}}}

if neobundle#tap('vim-quickrun') "{{{
  let g:quickrun_config.tex = {
        \ 'command': 'latexmk',
        \ 'outputter': 'error',
        \ 'cmdopt': '',
        \ 'exec': ['%c']}
  augroup tex_autocompile
    autocmd!
    autocmd BufWritePost *.tex QuickRun -runner vimproc
  augroup END
endif
"}}}
