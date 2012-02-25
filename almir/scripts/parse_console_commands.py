import re
import os
import argparse

source = "/home/ielectric/code/bacula/bacula/src/dird/ua_cmds.c"
# TODO: use argparse
regex = re.compile(r"""
   {\sNT_\("([^\)]+)"\)
   .+
   _\("([^)]+)"\)
   [,\s]+
   NT_\("([^)]+)"\)
""", re.X | re.M)

with open(source, 'r') as f:
    text = f.read()
    match = regex.findall(text)

__here__ = os.path.dirname(os.path.abspath(__file__))
with open(os.path.join(__here__, '..', 'lib', 'console_commands.py'), 'w') as f:
    f.write('# generated by almir/scripts/parse_console_commands.py\n')
    f.write('CONSOLE_COMMANDS = {\n')
    # TODO: parse help text to something more html friendly
    for c in match:
       f.write('    "%s": {"desc": "%s", "help": "%s"},\n' % c)
    f.write('}')
