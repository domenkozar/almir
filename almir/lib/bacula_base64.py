"""Taken from https://github.com/ZungBang/baculafs/blob/master/baculafs/Base64.py under GPLv3"""


# http://www.bacula.org/git/cgit.cgi/bacula/tree/bacula/src/findlib/attribs.c

def decode_base64(base64):
    """Bacula specific implementation of a base64 decoder"""
    digits = \
        ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
         'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
         'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
         'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
         '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '+', '/']

    base64_map = dict(zip(digits, xrange(0, 64)))

    value = 0
    first = 0
    neg = False

    if base64[0] == '-':
        neg = True
        first = 1

    for i in xrange(first, len(base64)):
        value = value << 6
        value += base64_map[base64[i]]

    return -value if neg else value
