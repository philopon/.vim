NeoBundleLazy 'davidhalter/jedi-vim', { 'autoload' : { 'filetypes': ['python'] } }
if neobundle#tap('jedi-vim')
  function! neobundle#tapped.hooks.on_source(bundle)
    let g:jedi#popup_on_dot = 0
    let g:neocomplete#force_omni_input_patterns.python = '[^. \t]\.\w*'
    augroup neocomplete_filespecific
      autocmd!
      autocmd FileType python setlocal omnifunc=jedi#completions
    augroup END
  endfunction
  call neobundle#untap()
endif

