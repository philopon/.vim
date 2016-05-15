def get_latest_version():
    import json
    try:
        from urllib.request import urlopen
    except ImportError:
        from urllib2 import urlopen

    f = urlopen('http://pypi.python.org/pypi/neovim/json')
    resp = json.loads(f.read().decode('utf-8'))

    return [int(i) for i in resp['info']['version'].split('.')]


def is_require_recheck(cache, interval):
    import os
    import time
    from datetime import datetime

    if os.path.isfile(cache):
        now = time.mktime(datetime.now().timetuple())
        return (now - os.path.getmtime(cache)) > interval

    else:
        return True


def load_last_version(cache, interval):
    try:
        import cPickle as pickle
    except ImportError:
        import pickle

    if is_require_recheck(cache, interval):
        last = get_latest_version()
        pickle.dump(last, open(cache, 'wb'), 0)
        return last

    else:
        return pickle.load(open(cache, 'rb'))


def get_installed_version():
    from pip.utils.outdated import get_installed_version
    return [int(i) for i in get_installed_version('neovim').split('.')]


def main():
    import sys
    import os

    _, cache, interval = sys.argv

    pip = 'pip{}.{}'.format(*sys.version_info[:2])

    args = [pip, 'install', 'neovim']

    if os.environ.get('VIRTUAL_ENV') is None:
        args.append('--user')

    try:
        import neovim
        neovim

        if get_installed_version() == load_last_version(cache, int(interval)):
            return 0

        args.append('-U')

    except ImportError:
        pass

    import subprocess
    subprocess.check_call(args)


if __name__ == '__main__':
    main()
