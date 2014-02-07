NeoBundleLazy 'davidhalter/jedi-vim', { 'autoload' : { 'filetypes': ['python'] } }
if neobundle#tap('jedi-vim')
  function! neobundle#tapped.hooks.on_source(bundle)
    let g:jedi#auto_initialization    = 0
    let g:jedi#auto_vim_configuration = 0
    let g:jedi#popup_on_dot           = 0
    let g:neocomplete#force_omni_input_patterns.python = '[^. \t]\.\w*'
    let g:jedi#show_call_signatures   = 0
    augroup neocomplete_filespecific
      autocmd!
      autocmd FileType python setlocal omnifunc=jedi#completions
    augroup END
  endfunction
  call neobundle#untap()
endif

