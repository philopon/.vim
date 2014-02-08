let s:save_cpo = &cpo
set cpo&vim

let s:homebrew_python2 = '/usr/local/Frameworks/Python.framework/Versions/2.7'

function! python_path_setting#set_path()
  python << EOF
import vim, sys, subprocess, cPickle
python = vim.eval('s:homebrew_python2') + '/bin/python'
path = cPickle.loads(subprocess.check_output([python, '-c', 'import sys, cPickle; print cPickle.dumps(sys.path, -1)']))
path = filter(lambda x: x != '', path)
path.append('_vim_path_')
sys.path = path
EOF
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
