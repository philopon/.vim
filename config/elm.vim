augroup ElmConfig
  autocmd!
augroup END

if neobundle#is_installed('elm.vim')
  source ~/.vim/bundle/elm.vim/ftdetect/elm.vim
  function! s:register_elm()
    vnoremap <buffer><silent> <Leader>t  :<c-u>ElmEvalSelection<CR>
    nnoremap <buffer><silent> <Leader>t  :<c-u>ElmEvalLine<CR>
  endfunction
  autocmd ElmConfig FileType elm call s:register_elm()
endif
