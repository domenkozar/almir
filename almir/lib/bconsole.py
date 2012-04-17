import re
import fcntl
import select
import os
import shlex
import tempfile
from contextlib import contextmanager
from subprocess import Popen, PIPE

from almir.lib.utils import nl2br


CURRENT_DIRECTORY = os.path.dirname(os.path.abspath(__file__))


# Full           Backup    10  04-Mar-12 23:05    BackupClient1      *unknown*
UPCOMING_JOB_REGEX = re.compile(r"""
    \s*(?P<level>\S+)\s+
    (?P<type>\S+)\s+
    (?P<priority>\d+)\s+
    (?P<date>\S+)\s+
    (?P<time>\d+:\d+)\s+
    (?P<name>\S+)\s+
    (?P<volume>\S+)\s*
""", re.X)


class BConsole(object):
    """Interface to bconsole binary"""

    def __init__(self, bconsole_command='bconsole -n -c %s', config_file=None):
        default_config_file = os.path.realpath(os.path.join(CURRENT_DIRECTORY, '..', '..', 'bconsole.conf'))
        self.config_file = config_file or default_config_file
        self.bconsole_command = bconsole_command % self.config_file

    @classmethod
    @contextmanager
    def from_temp_config(cls, name, address, port, password):
        """Constructs :class:`BConsole` object with help of passing temporary file for the session.
        """
        with tempfile.NamedTemporaryFile() as f:
            template = os.path.join(CURRENT_DIRECTORY, '..', '..', 'buildout.d', 'templates', 'bconsole.conf.in')
            with open(template) as f2:
                config = f2.read()\
                           .replace('${almir:director_name}', name)\
                           .replace('${almir:director_port}', port)\
                           .replace('${almir:director_password}', password)\
                           .replace('${almir:director_address}', address)
            f.write(config)
            f.flush()
            yield cls(config_file=f.name)

    def start_process(self):
        return Popen(shlex.split(self.bconsole_command), stdout=PIPE, stdin=PIPE, stderr=PIPE)

    def is_running(self):
        stdout, stderr = self.start_process().communicate('version')
        # TODO: output stdout, stderr on debug mode?
        if 'version' in stdout.lower():
            return True
        else:
            return False

    def get_upcoming_jobs(self):
        # TODO: we can do: .status dir scheduled days=10
        jobs = []
        p = self.start_process()
        stdout, stderr = p.communicate('.status dir scheduled\n')
        #if stderr.strip():
        #    pass  # TODO: display flash?
        for jobmatch in UPCOMING_JOB_REGEX.finditer(stdout):
            jobs.append(jobmatch.groupdict())

        return jobs

    def send_command_by_polling(self, command, process=None):
        """"""
        if command == 'quit':
            return process, {'commands': ['Try harder.']}

        # start bconsole session if it's not initialized
        if process is None:
            process = self.start_process()

        poll = process.poll()
        if poll is not None:
            process = None
            return process, {'error': 'Connection to director terminated with status %d. Refresh to reconnect.' % poll}

        # send bconsole command
        if command:
            process.stdin.write(command.strip().encode('utf-8') + '\n')

        # make stdout fileobject nonblockable
        fp = process.stdout.fileno()
        flags = fcntl.fcntl(fp, fcntl.F_GETFL)
        fcntl.fcntl(fp, fcntl.F_SETFL, flags | os.O_NONBLOCK)

        output = ''

        while 1:
            # wait for data or timeout
            [i, o, e] = select.select([fp], [], [], 1)
            if i:
                # we have more data
                output += process.stdout.read(1000)
            else:
                # we have a timeout
                output = nl2br(output)

                return process, {"commands": [output]}
