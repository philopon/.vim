let s:homebrew_python2 = '/usr/local/Frameworks/Python.framework/Versions/2.7'

if filereadable(s:homebrew_python2 . '/lib/libpython2.7.dylib')
  let $PYTHON_DLL = s:homebrew_python2 . '/lib/libpython2.7.dylib'
  call python_path_setting#set_path()
endif
