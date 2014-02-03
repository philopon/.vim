" NeoBundle 'git://git.code.sf.net/p/vim-latex/vim-latex'
if neobundle#tap('vim-latex')
  imap <C-g> <Plug>IMAP_JumpForward
  nmap <C-g> <Plug>IMAP_JumpForward
  map <c-e> <f5>
  map <c-c> <s-f5>
endif

" NeoBundle 'git://git.code.sf.net/p/atp-vim/code', {'name': 'atp-vim' }
if neobundle#tap('atp-vim')

endif

NeoBundle 'LaTeX-Box-Team/LaTeX-Box'
if neobundle#tap('LaTeX-Box')
  let g:LatexBox_no_mappings = 1
  let g:LatexBox_output_type = 'dvi'
  let g:LatexBox_viewer = 'open -a Skim'
endif

if neobundle#tap('vim-quickrun')
  let g:quickrun_config.tex = {
        \ 'command': 'latexmk',
        \ 'outputter': 'error',
        \ 'cmdopt': '',
        \ 'exec': ['%c']}
  autocmd BufWritePost *.tex QuickRun -runner vimproc
  autocmd FileType tex imap <buffer> [[     \begin{
  autocmd FileType tex imap <buffer> ]]     <Plug>LatexCloseCurEnv
  autocmd FileType tex nmap <buffer> [space]ec   <Plug>LatexChangeEnv
  autocmd FileType tex nmap <buffer> [space]es   <Plug>LatexToggleStarEnv
  autocmd FileType tex vmap <buffer> <F7>   <Plug>LatexWrapSelection
  autocmd FileType tex vmap <buffer> <S-F7> <Plug>LatexEnvWrapSelection
endif
