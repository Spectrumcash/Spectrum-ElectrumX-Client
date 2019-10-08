# -*- coding: utf-8 -*-

import sys


try:
    from ltc_scrypt import getPoWHash
    import_success = True
    load_libltcscrypt = False
except ImportError:
    import_success = False
    load_libltcscrypt = True


if load_libltcscrypt:
    from ctypes import cdll, create_string_buffer, byref

    if sys.platform == 'darwin':
        name = 'libltcscrypt.dylib'
    elif sys.platform in ('windows', 'win32'):
        name = 'libltcscrypt-0.dll'
    else:
        name = 'libltcscrypt.so'

    try:
        lltcscrypt = cdll.LoadLibrary(name)
        ltcscrypt = lltcscrypt.ltc_scrypt
    except:
        load_libltcscrypt = False


if load_libltcscrypt:
    hash_out = create_string_buffer(32)

    def getPoWHash(header):
        x16rt_hash(header, byref(hash_out))
        return hash_out.raw


if not import_success and not load_libltcscrypt:
    raise ImportError('Can not import x16rt_hash')
