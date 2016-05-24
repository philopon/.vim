try:
    from urllib.request import urlopen
except ImportError:
    from urllib2 import urlopen

import json


def get_latest_version():
    f = urlopen('http://pypi.python.org/pypi/neovim/json')
    resp = json.loads(f.read().decode('utf-8'))

    return resp['info']['version']


if __name__ == '__main__':
    print(get_latest_version())
