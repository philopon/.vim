let g:jedi#force_py_version = str2nr(system('python -c "import sys; print(sys.version_info.major)"'))
call plug#load('jedi-vim')
