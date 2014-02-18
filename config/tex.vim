autocmd FileType plaintex set filetype=tex

NeoBundleLazy 'LaTeX-Box-Team/LaTeX-Box', { 'autoload' : { 'filetypes': ['tex'] } } "{{{
if neobundle#tap('LaTeX-Box')
  function neobundle#tapped.hooks.on_source(bundle)
    let g:LatexBox_no_mappings = 1
    let g:LatexBox_Folding = 1
    let g:LatexBox_output_type = 'pdf'
    let g:LatexBox_viewer = 'open -a Skim'

    augroup config_tex_keymap
      autocmd!
      autocmd FileType tex imap <buffer> [[     \begin{
      autocmd FileType tex imap <buffer> ]]     <Plug>LatexCloseCurEnv
      autocmd FileType tex nmap <buffer> [space]ec   <Plug>LatexChangeEnv
      autocmd FileType tex nmap <buffer> [space]es   <Plug>LatexToggleStarEnv
      autocmd FileType tex vmap <buffer> <F7>   <Plug>LatexWrapSelection
      autocmd FileType tex vmap <buffer> <S-F7> <Plug>LatexEnvWrapSelection
    augroup END
  endfunction

  if exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns.tex =
          \ '\v\\\a*(ref|cite)\a*([^]]*\])?\{(|[^}]*,)'
  endif
  
  call neobundle#untap()
endif
"}}}

if neobundle#is_installed('vim-quickrun') "{{{

  let $max_print_line = 9999

  let g:quickrun_config.tex = {
        \ 'command': 'latexmk',
        \ 'outputter': 'null',
        \ 'runner': 'vimproc',
        \ 'runner/vimproc/updatetime': 100,
        \ 'hook/latex_compile/enable': 1,
        \ 'hook/cd/enable': 1,
        \ 'hook/cd/directory': '%S:h',
        \ 'exec':         '%c -pdfdvi -quiet %s'
        \ }

  let b:latex_auto_partial_compile = 1
  let g:latex_auto_partial_compile = 1

  function! s:latex_partial_compile()
    if b:latex_auto_partial_compile && g:latex_auto_partial_compile
      QuickRun -hook/latex_compile/partial_enable 1
    endif
  endfunction

  augroup config_tex_autocompile
    autocmd!
    autocmd QuitPre *.tex let g:latex_auto_partial_compile = 0
    autocmd BufRead ~/.vim/template/tex/* let b:latex_auto_partial_compile = 0
    autocmd BufWritePost *.tex call s:latex_partial_compile()
  augroup END
endif
"}}}

