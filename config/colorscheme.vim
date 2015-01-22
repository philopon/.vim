if neobundle#is_installed('vim-hybrid')
  let g:hybrid_use_Xresources = 1
  colorscheme hybrid
endif

if &t_Co == 256
  highlight LineNr ctermfg=242
  highlight CursorLineNr ctermfg=245
endif


