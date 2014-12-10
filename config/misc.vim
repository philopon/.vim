augroup MiscConfig
  autocmd!
augroup END

if neobundle#is_installed('neocomplete.vim') " {{{
  let g:neocomplete#enable_at_startup = 1
  let g:neocomplete#enable_smart_case = 1
  let g:neocomplete#disable_auto_complete = 1

  inoremap <expr><C-g>     neocomplete#undo_completion()
  inoremap <expr><C-l>     neocomplete#complete_common_string()

  inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
  function! s:my_cr_function()
    return neocomplete#close_popup() . "\<CR>"
  endfunction

  inoremap <expr><c-n> pumvisible() ? "\<down>" : neocomplete#start_manual_complete() 
  inoremap <expr><c-p> pumvisible() ? "\<up>" : neocomplete#start_manual_complete() 
endif " }}}

if neobundle#is_installed('lightline.vim') " {{{
  let g:lightline = {}

  if neobundle#is_installed('lightline-hybrid.vim')
    let g:lightline.colorscheme = 'hybrid'
  endif

  let g:lightline.component = {
        \ 'readonly': '%{&readonly?"\uE0A2":""}',
        \ 'paste': '%{&paste?"\u270E":""}',
        \ 'dummy': ''
        \ }

  let g:lightline.component_function = {
        \ 'fugitive': 'MyFugitive',
        \ 'filename': 'MyFilename',
        \ 'fileencoding': 'MyEncoding',
        \ 'gitgutter': 'MyGitGutter'
        \ }

  function! MyFugitive()
    if exists("*fugitive#head")
      let _ = fugitive#head()
      return strlen(_) ? "\uE0A0"._ : ''
    endif
    return ''
  endfunction

  function! MyGitGutter()
    if exists('*GitGutterGetHunkSummary')
      let [plus, modify, minus] = GitGutterGetHunkSummary()
      if plus != 0 || modify != 0 || minus != 0
        return '+' . plus . ' ~' . modify . ' -' . minus
      endif
    endif
    return ''
  endfunction

  function! MyFilename()
    let _ = expand("%:t")
    let result = "" != _ ? _ : '[No Name]'
    if &filetype != 'help' && &modified
      let result = result . " +"
    endif
    return result
  endfunction

  function! MyEncoding()
    let result = strlen(&fenc) ? &fenc : &enc
    if &fileformat == 'dos'
      let result = result . "\u21b2"
    elseif &fileformat == 'mac'
      let result = result . "\u2190"
    else
      let result = result . "\u2193"
    endif
    return result
  endfunction

  let g:lightline.separator = { 'left': "\uE0B0", 'right': "\uE0B2" }
  let g:lightline.subseparator = { 'left': "\uE0B1", 'right': "\uE0B3" }
  let g:lightline.active = {
        \ 'left' : [['paste'], ['fugitive', 'gitgutter'], ['readonly', 'filename']],
        \ 'right': [['lineinfo'], ['dummy'], ['filetype', 'fileencoding']]
        \ }
endif " }}}

if neobundle#is_installed('vim-easymotion') " {{{
  let g:EasyMotion_do_mapping = 0
  let g:EasyMotion_smartcase  = 1
  map s <Plug>(easymotion-s)
  map <Leader>j <Plug>(easymotion-j)
  map <Leader>k <Plug>(easymotion-k)
endif " }}}

if neobundle#is_installed('vim-markdown')
  source ~/.vim/bundle/vim-markdown/ftdetect/mkd.vim
endif

if neobundle#is_installed('previm')
  function! s:register_previm_mapping()
    nnoremap <buffer><silent> <Leader>p :<C-u>PrevimOpen<CR>
  endfunction
  autocmd MiscConfig FileType mkd call s:register_previm_mapping()
endif

if neobundle#is_installed('unite.vim')
  let g:unite_enable_start_insert = 1

  if executable('ag')
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
    let g:unite_source_grep_recursive_opt = ''
  endif

  nnoremap <silent> <Leader>g :<C-u>Unite grep:.<CR>
  nnoremap <silent> <Leader>b :<C-u>Unite buffer<CR>
endif

" vim: foldmethod=marker
