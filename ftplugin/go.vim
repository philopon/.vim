autocmd FileType go highlight goExtraVars cterm=bold ctermfg=red
autocmd FileType go match goExtraVars /\<ok\>\|\<err\>/
