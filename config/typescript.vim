augroup TypeScriptConfig
  autocmd!
augroup END

if neobundle#is_installed('neocomplete.vim') && neobundle#is_installed('tsuquyomi')
  let g:neocomplete#force_omni_input_patterns.typescript = '\h\w*'
  " let g:neocomplete#sources#omni#input_patterns.typescript = '\h\w*\|[^. \t]\.\w*'
endif

