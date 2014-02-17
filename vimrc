if has('vim_starting') " NeoBundle {{{
  set nocompatible
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle'))

NeoBundleFetch 'Shougo/neobundle.vim'
"}}}

NeoBundle 'thinca/vim-quickrun' "{{{
if neobundle#is_installed('vim-quickrun')
  nnoremap [space]r :<C-u>QuickRun<CR>
  nnoremap [space]R :<C-u>QuickRun -args 
  if !exists('g:quickrun_config')
    let g:quickrun_config = {}
  endif
endif
"}}}

" Shougo/vimproc {{{
NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \     'windows' : 'make -f make_mingw32.mak',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }
"}}}

NeoBundle 'scrooloose/syntastic' "{{{
if neobundle#is_installed('syntastic')
  let g:syntastic_always_populate_loc_list=1
  let g:syntastic_enable_highlighting = 1
  let g:syntastic_error_symbol = "\u2717"
  let g:syntastic_warning_symbol = "\u26a0"
  autocmd CursorHold * SyntasticCheck
  nnoremap [space]j :<c-u>lnext<CR>
  nnoremap [space]k :<c-u>lprevious<CR>
endif
"}}}

NeoBundle 'sjl/gundo.vim' "{{{
if neobundle#is_installed('gundo.vim')
  nnoremap [space]g :<C-u>GundoToggle<CR>
endif
"}}}

if has('lua') " Shougo/neocomplete {{{
  NeoBundle 'Shougo/neocomplete'
  if neobundle#is_installed('neocomplete') 
    let g:acp_enableAtStartup = 0
    let g:neocomplete#enable_at_startup = 1
    let g:neocomplete#enable_smart_case = 1
    let g:neocomplete#force_overwrite_completefunc = 1
    let g:neocomplete#sources#syntax#min_keyword_length = 3
    let g:neocomplete#enable_auto_close_preview = 0

    inoremap <expr><C-g>     neocomplete#undo_completion()
    inoremap <expr><C-l>     neocomplete#complete_common_string()

    " <CR>: close popup and save indent.
    inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    function! s:my_cr_function()
      return neocomplete#close_popup() . "\<CR>"
      " For no inserting <CR> key.
      "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
    endfunction
    " <TAB>: completion.
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
    " <C-h>, <BS>: close popup and delete backword char.
    inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><C-y>  neocomplete#close_popup()
    inoremap <expr><C-e>  neocomplete#cancel_popup()

    augroup vimrc_neocomplete_filespecific
      autocmd!
      autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
      autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
      autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
      autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
    augroup END

    if !exists('g:neocomplete#force_omni_input_patterns')
      let g:neocomplete#force_omni_input_patterns = {}
    endif
  endif
endif
"}}}

NeoBundle 'Shougo/neosnippet.vim' "{{{
NeoBundle 'git@github.com:philopon/neosnippet-snippets.git'
if neobundle#is_installed('neosnippet.vim')
  " Plugin key-mappings.
  imap <C-k>     <Plug>(neosnippet_expand_or_jump)
  smap <C-k>     <Plug>(neosnippet_expand_or_jump)
  xmap <C-k>     <Plug>(neosnippet_expand_target)
endif
"}}}

NeoBundle 'tpope/vim-surround'
NeoBundle 'kana/vim-smartchr'

NeoBundle 'vim-scripts/restore_view.vim'

NeoBundle 'tpope/vim-fugitive'
NeoBundle 'airblade/vim-gitgutter'

NeoBundle 'kien/ctrlp.vim' "{{{
if neobundle#is_installed('ctrlp.vim')
  let g:ctrlp_use_migemo = 1
  nnoremap [space]p :<C-U>CtrlPMixed<CR>
  nnoremap [space]b :<C-U>CtrlPBuffer<CR>
endif "}}}

NeoBundle 'itchyny/lightline.vim' "{{{
NeoBundle 'cocopon/lightline-hybrid.vim'
if neobundle#is_installed('lightline.vim')
  if !exists('g:lightline')
    let g:lightline = {}
  endif
  if neobundle#is_installed('lightline-hybrid.vim')
    let g:lightline.colorscheme = 'hybrid'
  endif
  let g:lightline.component = {
        \ 'readonly': '%{&readonly?"\u2b64":""}',
        \ 'paste':    '%{&paste?"\u270e":""}',
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
      return strlen(_) ? "\u2b60"._ : ''
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

  let g:lightline.separator = { 'left': "\u2b80", 'right': "\u2b82" }
  let g:lightline.subseparator = { 'left': "\u2b81", 'right': "\u2b83" }

  let g:lightline.active = {
        \ 'left' : [['paste'], ['fugitive', 'gitgutter'], ['readonly', 'filename']],
        \ 'right': [['lineinfo'], ['dummy'], ['filetype', 'fileencoding']]
        \ }

  set ambiwidth=double

endif "}}}

NeoBundle 'mattn/sonictemplate-vim' "{{{
if neobundle#is_installed('sonictemplate-vim')
  let g:sonictemplate_vim_template_dir = '~/.vim/template'
  nnoremap [space]t :<C-u>CtrlPSonictemplate<CR>
endif

NeoBundle 'kaneshin/ctrlp-sonictemplate'
"}}}

NeoBundle 'kana/vim-textobj-user'
NeoBundle 'kana/vim-textobj-line'
NeoBundle 'kana/vim-textobj-lastpat'
NeoBundle 'kana/vim-textobj-fold'
NeoBundle 'mattn/vim-textobj-url'

" Language specific configuration {{{
source $HOME/.vim/config/haskell.vim
source $HOME/.vim/config/python.vim
source $HOME/.vim/config/tex.vim
"}}}

" Platform Specific configuration {{{
if has('macunix')
  source $HOME/.vim/config/macunix.vim
endif
"}}}

source $HOME/.vim/config/global.vim

NeoBundleCheck

