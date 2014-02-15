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

NeoBundle 'Shougo/unite.vim' "{{{
if neobundle#is_installed('unite.vim')
  let g:unite_enable_start_insert=1
  let g:unite_source_history_yank_enable = 1
  nnoremap <silent> [unite]f :<C-u>Unite file file/new<CR>
  nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
  nnoremap <silent> [unite]p :<C-u>Unite history/yank<CR>
endif
"}}}

NeoBundle 'osyo-manga/unite-quickfix'

NeoBundle 'osyo-manga/vim-watchdogs'

NeoBundle 'scrooloose/syntastic' "{{{
if neobundle#is_installed('syntastic')
  let g:syntastic_always_populate_loc_list=1
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
NeoBundle 'airblade/vim-gitgutter' "{{{
if neobundle#is_installed('vim-gitgutter')
  augroup vimrc_gitgutter
    autocmd!
    autocmd InsertLeave * GitGutterAll
    autocmd InsertEnter * GitGutterAll
  augroup END
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

endif "}}}

NeoBundle 'aperezdc/vim-template' "{{{
if neobundle#is_installed('vim-template')
  let g:template_dir = '~/.vim/template'
endif
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

