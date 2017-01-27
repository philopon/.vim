function! local#dein#ctrlp#hook_source() abort
    let g:ctrlp_cmd = 'CtrlPBuffer'
    let g:ctrlp_working_path_mode = 'ra'
    let g:ctrlp_extensions = ['quickfix', 'undo']
    let g:ctrlp_custom_ignore = '\vnode_modules'
endfunction
