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
        ltc_scrypt = lltcscrypt.ltc_scrypt
    except:
        load_libx11hash = False


if load_libltcscrypt:
    hash_out = create_string_buffer(32)

    def getPoWHash(header):
        ltc_scrypt(header, byref(hash_out))
        return hash_out.raw


if not import_success and not load_libx11hash:
    raise ImportError('Can not import ltc_scrypt')
