import shlex
from subprocess import Popen, PIPE


class BConsole(object):
    """Interface to bconsole binary"""

    # TODO: make sudo optional
    def __init__(self, bconsole_command='bconsole -n'):
        self.bconsole_command = bconsole_command

    def run_command(self, cmd):
        # TODO: possibility for evil injection?
        p = Popen(shlex.split(self.bconsole_command), stdout=PIPE, stdin=PIPE, stderr=PIPE)
        return p.communicate(cmd)

    def get_director_version(self):
        stdout, stderr = self.run_command('version')

    def get_bconsole_version(self):
        stdout, stderr = self.run_command('@version')
