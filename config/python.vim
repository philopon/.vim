NeoBundle 'davidhalter/jedi-vim'

augroup neocomplete_filespecific
  autocmd!
  autocmd FileType python setlocal omnifunc=jedi#completions
augroup END
