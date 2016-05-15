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
    if is_require_recheck(cache, interval):
        last = get_latest_version()

        with open(cache, 'w') as f:
            f.write('.'.join(str(i) for i in last))

        return last

    else:
        with open(cache) as f:
            return [int(i) for i in f.read().split('.')]


def get_installed_version():
    import pkg_resources

    try:
        return [int(i) for i in pkg_resources.get_distribution('neovim').version.split('.')]
    except pkg_resources.DistributionNotFound:
        return None


def main():
    import sys

    args = ['pip{}.{}'.format(*sys.version_info[:2]), 'install', 'neovim']

    cur = get_installed_version()

    if cur is not None:
        _, cache, interval = sys.argv
        if cur == load_last_version(cache, int(interval)):
            return 0

        args.append('-U')

    import os

    if os.environ.get('VIRTUAL_ENV') is None:
        args.append('--user')

    import subprocess
    subprocess.check_call(args)
    return 1


if __name__ == '__main__':
    import sys
    sys.exit(main())
