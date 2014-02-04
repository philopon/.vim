NeoBundleLazy 'davidhalter/jedi-vim', { 'autoload' : { 'filetypes': ['python'] } }
if neobundle#tap('jedi-vim')
  function! neobundle#tapped.hooks.on_source(bundle)
    augroup neocomplete_filespecific
      autocmd!
      autocmd FileType python setlocal omnifunc=jedi#completions
    augroup END
  endfunction
  call neobundle#untap()
endif

