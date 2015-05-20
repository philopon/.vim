augroup PureScriptConfig
  autocmd!
augroup END

if neobundle#is_installed('purescript-vim')
  source ~/.vim/bundle/purescript-vim/ftdetect/purescript.vim
endif

autocmd PureScriptConfig FileType purescript syntax sync fromstart
