if has('vim_starting') " NeoBundle {{{
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle'))

NeoBundleFetch 'Shougo/neobundle.vim'
"}}}

" Nebula LeafCage/nebula.vim {{{
NeoBundleLazy 'LeafCage/nebula.vim', {'autoload': {'commands': ['NebulaPutLazy', 'NebulaPutFromClipboard', 'NebulaYankOptions', 'NebulaYankConfig', 'NebulaPutConfig', 'NebulaYankTap']}}
" }}}

" Lazy thinca/vim-quickrun {{{
NeoBundleLazy 'thinca/vim-quickrun',
      \ {'autoload': {
      \      'mappings': [['sxn', '<Plug>(quickrun']],
      \      'commands': [{'complete': 'customlist,quickrun#complete', 'name': 'QuickRun'}]},
      \  'depends':  'Shougo/vimproc'}
if neobundle#is_installed('vim-quickrun')
  nnoremap [space]r :<C-u>QuickRun<CR>
  nnoremap [space]R :<C-u>QuickRun -args 
  nnoremap [space]s :<C-u>QuickRun -runner shell<CR>
  if !exists('g:quickrun_config')
    let g:quickrun_config = {}
  endif
endif
"}}}

" Nebula Shougo/vimproc {{{
NeoBundleLazy 'Shougo/vimproc', {'autoload': {'commands': [{'complete': 'shellcmd', 'name': 'VimProcBang'}, {'complete': 'shellcmd', 'name': 'VimProcRead'}]}
      \,'build' : {
      \   'windows' : 'make -f make_mingw32.mak',
      \   'cygwin' : 'make -f make_cygwin.mak',
      \   'mac' : 'make -f make_mac.mak',
      \   'unix' : 'make -f make_unix.mak',
      \   }
      \ }
"}}}

" Nebula scrooloose/syntastic {{{
" NeoBundleLazy 'scrooloose/syntastic', {'autoload': {'commands': [{'complete': 'custom,s:CompleteCheckerName', 'name': 'SyntasticCheck'}, {'complete': 'custom,s:CompleteFiletypes', 'name': 'SyntasticInfo'}, 'Errors', 'SyntasticSetLoclist', 'SyntasticReset', 'SyntasticToggleMode']}}
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

" Nebula sjl/gundo.vim {{{
NeoBundleLazy 'sjl/gundo.vim', {'autoload': {'commands': ['GundoHide', 'GundoShow', 'GundoRenderGraph', 'GundoToggle']}}
if neobundle#is_installed('gundo.vim')
  nnoremap [space]g :<C-u>GundoToggle<CR>
endif
"}}}

" Strict Shougo/neocomplete {{{
if has('lua')
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

" Strict Shougo/neosnippet.vim {{{
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'git@github.com:philopon/neosnippet-snippets.git'
if neobundle#is_installed('neosnippet.vim')
  " Plugin key-mappings.
  imap <C-k>     <Plug>(neosnippet_expand_or_jump)
  smap <C-k>     <Plug>(neosnippet_expand_or_jump)
  xmap <C-k>     <Plug>(neosnippet_expand_target)
endif
"}}}


" Nebula LeafCage/yankround.vim {{{
NeoBundleLazy 'LeafCage/yankround.vim', {'autoload': {'unite_sources': ['yankround'], 'mappings': [['n', '<Plug>(yankround-']]}}
if neobundle#is_installed('yankround.vim')
  nmap p  <Plug>(yankround-p)
  nmap P  <Plug>(yankround-P)
  nmap gp <Plug>(yankround-gp)
  nmap gP <Plug>(yankround-gP)
  nmap <c-p> <Plug>(yankround-prev)
  nmap <c-n> <Plug>(yankround-next)
  let g:yankround_use_region_hl = 1
  nnoremap [space]p :<c-u>Unite yankround<CR>
endif
"}}}

NeoBundle 'vim-scripts/restore_view.vim'

NeoBundle 'tpope/vim-fugitive'
NeoBundle 'airblade/vim-gitgutter'

NeoBundle 'Shougo/context_filetype.vim'

" Nebula Shougo/unite.vim {{{
NeoBundleLazy 'Shougo/unite.vim', {'augroup': 'plugin', 'autoload': {'unite_sources': ['action', 'alias', 'bookmark', 'buffer', 'change', 'command', 'directory', 'file', 'file_point', 'find', 'function', 'grep', 'history_input', 'history_yank', 'interactive', 'jump', 'jump_point', 'launcher', 'line', 'mapping', 'menu', 'mru', 'output', 'process', 'rec', 'register', 'resume', 'runtimepath', 'source', 'tab', 'undo', 'vimgrep', 'window'], 'commands': [{'complete': 'customlist,unite#complete#source', 'name': 'UniteWithCurrentDir'}, {'complete': 'customlist,unite#complete#source', 'name': 'Unite'}, {'complete': 'customlist,unite#complete#source', 'name': 'UniteWithInputDirectory'}, {'complete': 'customlist,unite#complete#buffer_name', 'name': 'UniteClose'}, {'complete': 'file', 'name': 'UniteBookmarkAdd'}, {'complete': 'customlist,unite#complete#buffer_name', 'name': 'UniteResume'}, {'complete': 'customlist,unite#complete#source', 'name': 'UniteWithBufferDir'}, {'complete': 'customlist,unite#complete#source', 'name': 'UniteWithCursorWord'}, {'complete': 'customlist,unite#complete#source', 'name': 'UniteWithInput'}]}}
if neobundle#is_installed('unite.vim')
  let g:unite_enable_start_insert = 1
  nnoremap [space]u :<c-u>Unite<CR>
  nnoremap [space]b :<c-u>Unite buffer<CR>
endif
"}}}

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

" Lazy mattn/sonictemplate-vim {{{
NeoBundleLazy 'mattn/sonictemplate-vim', {'autoload': {
      \ 'unite_sources': ['sonictemplate'],
      \ 'mappings': [['in', '<Plug>(sonictemplate']],
      \ 'functions': ['sonictemplate#complete'],
      \ 'commands': [{'name': 'Template', 'complete': 'customlist,sonictemplate#complete'}]}}
if neobundle#is_installed('sonictemplate-vim')
  let g:sonictemplate_vim_template_dir = '~/.vim/template'
endif

NeoBundle 'kaneshin/ctrlp-sonictemplate'
"}}}

NeoBundle 'kana/vim-textobj-user'
NeoBundle 'kana/vim-textobj-line'
NeoBundle 'kana/vim-textobj-lastpat'
NeoBundle 'kana/vim-textobj-fold'
NeoBundle 'kana/vim-textobj-entire'
NeoBundle 'mattn/vim-textobj-url'

NeoBundle 'kana/vim-operator-user'
NeoBundle 'emonkak/vim-operator-comment'

NeoBundle 'rizzatti/funcoo.vim'
NeoBundle 'rizzatti/dash.vim'

" Nebula Lokaltog/vim-easymotion {{{
NeoBundleLazy 'Lokaltog/vim-easymotion', {'autoload': {'mappings': [['sxno', '<Plug>(easymotion-']], 'commands': ['EMCommandLineNoreMap', 'EMCommandLineMap', 'EMCommandLineUnMap']}}
if neobundle#is_installed('vim-easymotion')
  nmap s <Plug>(easymotion-s)
  vmap s <Plug>(easymotion-s)
  omap z <Plug>(easymotion-s)
  nmap [space]j <Plug>(easymotion-j)
  nmap [space]k <Plug>(easymotion-k)
  let g:EasyMotion_use_migemo = 1
  let g:EasyMotion_smartcase  = 1
endif
" }}}

" Language specific configuration {{{
source $HOME/.vim/config/haskell.vim
source $HOME/.vim/config/python.vim
source $HOME/.vim/config/tex.vim

augroup vimrc_markdown
  autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
augroup END
"}}}

" Platform Specific configuration {{{
if has('macunix')
  source $HOME/.vim/config/macunix.vim
endif
"}}}

source $HOME/.vim/config/global.vim

NeoBundleCheck

