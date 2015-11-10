" initialize NeoBundle {{{
if 0 | endif

if has('vim_starting')
    if &compatible
        set nocompatible
    endif

    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
set runtimepath+=~/.vim/neobundle

call neobundle#begin()
NeoBundleFetch 'Shougo/neobundle.vim'
"}}}

" config {{{

" files {{{
let windows = has('win32') || has('win64')

if windows
    set directory=C:/Temp
else
    set directory=/tmp
endif

let backupdir = expand("~/.vim/backup")
if !isdirectory(backupdir)
    call mkdir(backupdir)
endif
let &backupdir = backupdir

let undodir = expand("~/.vim/undo")
if !isdirectory(undodir)
    call mkdir(undodir)
endif
let &undodir = undodir
"}}}

let mapleader = "\<Space>"
let maplocalleader = "\<Space>"

set number cmdheight=1 visualbell noerrorbells background=dark

set list listchars=tab:▸\ ,eol:↲,extends:»

set clipboard=unnamed,unnamedplus

set shellslash

set wildmode=list:longest history=10000

" indent
set autoindent smartindent shiftwidth=4 tabstop=4 softtabstop=4 expandtab
" }}}

" keymap {{{
nnoremap x "_x
nmap zf zMzv
"}}}

" packages "{{{
NeoBundle 'tomasr/molokai'

" misc {{{
NeoBundle 'Shougo/neocomplete.vim' "{{{

if neobundle#tap('neocomplete.vim')

    call neobundle#config(
                \ { 'depends': 'Shougo/context_filetype.vim',
                \   'disabled': !has('lua'),
                \   'vim_version' : '7.3.885',
                \   'lazy': 1,
                \   'autoload': { 'insert': 1 }
                \ })

    if !neobundle#tapped.disabled

        let g:acp_enableAtStartup = 0
        let g:neocomplete#enable_at_startup = 1
        let g:neocomplete#enable_smart_case = 1

        let g:neocomplete#sources#syntax#min_keyword_length = 3
        let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
      
        if !exists('g:neocomplete#keyword_patterns')
            let g:neocomplete#keyword_patterns = {}
        endif
        let g:neocomplete#keyword_patterns['default'] = '\h\w*'

        " Plugin key-mappings.
        inoremap <expr><C-g>     neocomplete#undo_completion()
        inoremap <expr><C-l>     neocomplete#complete_common_string()
      
        " Recommended key-mappings.
        " <CR>: close popup and save indent.
        inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
        function! s:my_cr_function()
            return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
            " For no inserting <CR> key.
            "return pumvisible() ? "\<C-y>" : "\<CR>"
        endfunction
        " <TAB>: completion.
        inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
        " <C-h>, <BS>: close popup and delete backword char.
        inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
        inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
        " Close popup by <Space>.
        "inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

        " AutoComplPop like behavior.
        "let g:neocomplete#enable_auto_select = 1
      
        " Shell like behavior(not recommended).
        "set completeopt+=longest
        "let g:neocomplete#enable_auto_select = 1
        "let g:neocomplete#disable_auto_complete = 1
        "inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"
      
        " Enable omni completion.
        autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
        autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
        autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
        autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
      
        " Enable heavy omni completion.
        if !exists('g:neocomplete#sources#omni#input_patterns')
            let g:neocomplete#sources#omni#input_patterns = {}
        endif
        "let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
        "let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
        "let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

        " For perlomni.vim setting.
        " https://github.com/c9s/perlomni.vim
        let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
    endif

    call neobundle#untap()
endif "}}}

NeoBundle 'Shougo/vimproc.vim' "{{{

if neobundle#tap('vimproc.vim')
    call neobundle#config(
                \ { 'build':
                \   { 'windows' : 'tools\\update-dll-mingw',
                \     'cygwin' : 'make -f make_cygwin.mak',
                \     'mac' : 'make',
                \     'linux' : 'make',
                \     'unix' : 'gmake',
                \   }
                \ })
  call neobundle#untap()
endif "}}}

NeoBundle 'Shougo/unite.vim' "{{{

if neobundle#tap('unite.vim')
    call neobundle#config(
                \ { 'lazy': 1,
                \   'autoload': { 'commands': ['Unite']}
                \ })

    nmap <silent> <Leader>b :Unite buffer<CR>

    let g:unite_enable_start_insert=1
    call neobundle#untap()
endif

"}}}

NeoBundle 'Shougo/neosnippet' "{{{
if neobundle#tap('neosnippet')
    call neobundle#config(
                \ { 'depends': ['philopon/neosnippet-snippets'],
                \   'lazy': 1,
                \   'insert': 1
                \ })

    " Plugin key-mappings.
    imap <C-k>     <Plug>(neosnippet_expand_or_jump)
    smap <C-k>     <Plug>(neosnippet_expand_or_jump)
    xmap <C-k>     <Plug>(neosnippet_expand_target)

    " SuperTab like snippets behavior.
    "imap <expr><TAB>
    " \ pumvisible() ? "\<C-n>" :
    " \ neosnippet#expandable_or_jumpable() ?
    " \    "\<TAB>" : "\<Plug>(neosnippet_expand_or_jump)"
    smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
                \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

    " For conceal markers.
    if has('conceal')
      set conceallevel=2 concealcursor=niv
    endif

    call neobundle#untap()
endif
"}}}
"}}}

" python {{{

NeoBundle 'nvie/vim-flake8' "{{{
if neobundle#tap('vim-flake8')
    call neobundle#config(
                \ { 'lazy': 1,
                \   'autoload':
                \   { 'filetypes': ['python'],
                \     'commands': ['Flake8']
                \   }
                \ })
    
    augroup vimrc_vim_flake8
        autocmd!
        autocmd BufWritePost *.py call Flake8()
    augroup END
    call neobundle#untap()
endif "}}}

NeoBundle 'davidhalter/jedi-vim' "{{{
if neobundle#tap('jedi-vim')
    call neobundle#config(
                \ { 'lazy': 1,
                \   'autoload':
                \   { 'filetypes': ['python'],
                \     'insert': 1
                \   }
                \ })
    
    augroup vimrc_jedi_vim
        autocmd!
        autocmd FileType python setlocal completeopt-=preview
    augroup END
    call neobundle#untap()
endif "}}}

NeoBundle 'hynek/vim-python-pep8-indent' "{{{
if neobundle#tap('vim-python-pep8-indent')
    call neobundle#config(
                \ { 'lazy': 1,
                \   'autoload':
                \   { 'filetypes': ['python'],
                \     'insert': 1
                \   }
                \ })
    
    call neobundle#untap()
endif "}}}
" }}}

" latex {{{
NeoBundle 'lervag/vimtex'
if neobundle#tap('vimtex')

    call neobundle#config(
                \ { 'lazy': 1,
                \   'autoload': {'filetypes': ['tex']}
                \ })

    let g:tex_conceal=''

    let g:vimtex_fold_enabled = 1
    let g:vimtex_fold_automatic = 1
    let g:vimtex_fold_envs = 1
    let g:vimtex_fold_preamble = 1

    let g:vimtex_quickfix_ignore_all_warnings = 1

    if exists('g:neocomplete#sources#omni#input_patterns')
        let g:neocomplete#sources#omni#input_patterns.tex = '\v\\\a*(ref|cite|eqref)\a*([^]]*\])?\{([^}]*,)*[^}]*'
    endif

    if has('mac')
        let g:vimtex_view_general_viewer = 'displayline'
        let g:vimtex_view_general_options = '-b -g @line @pdf @tex'
    endif

    call neobundle#untap()
endif
"}}}


"}}}

" finalize NeoBundle {{{
call neobundle#end()

colorscheme molokai

filetype plugin indent on
NeoBundleCheck
"}}}
" vim:set foldmethod=marker:
