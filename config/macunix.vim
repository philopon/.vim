let s:homebrew_python2 = '/usr/local/Frameworks/Python.framework/Versions/2.7'

if filereadable(s:homebrew_python2 . '/lib/libpython2.7.dylib')
  let $PYTHON_DLL = s:homebrew_python2 . '/lib/libpython2.7.dylib'
  python << EOF
import vim, sys, subprocess, cPickle
python = vim.eval('s:homebrew_python2') + '/bin/python'
path = cPickle.loads(subprocess.check_output([python, '-c', 'import sys, cPickle; print cPickle.dumps(sys.path, -1)']))
path = filter(lambda x: x != '', path)
path.append('_vim_path_')
sys.path = path
EOF
endif
