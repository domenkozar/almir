import re
import os
import shlex
from subprocess import Popen, PIPE


CURRENT_DIRECTORY = os.path.dirname(os.path.abspath(__file__))


# Full           Backup    10  04-Mar-12 23:05    BackupClient1      *unknown*
UPCOMING_JOB_REGEX = re.compile(r"""
    \s*(?P<level>\S+)\s+
    (?P<type>\S+)\s+
    (?P<priority>\d+)\s+
    (?P<date>\S+)\s+
    (?P<time>\d+:\d+)\s+
    (?P<name>\S+)\s+
    (?P<volume>\S+)\s*""", re.X)


class BConsole(object):
    """Interface to bconsole binary"""

    # TODO: use sudo?
    def __init__(self, bconsole_command='bconsole -n -c %s' % os.path.join(CURRENT_DIRECTORY, '..', '..', 'bconsole.conf')):
        self.bconsole_command = bconsole_command

    def start_process(self):
        return Popen(shlex.split(self.bconsole_command), stdout=PIPE, stdin=PIPE, stderr=PIPE)

    def get_upcoming_jobs(self):
        jobs = []
        p = self.start_process()
        stdout, stderr = p.communicate('.status dir scheduled\n')
        if stderr.strip():
            pass  # TODO: display flash?
        for jobmatch in UPCOMING_JOB_REGEX.finditer(stdout):
            jobs.append(jobmatch.groupdict())

        return jobs


    #def get_director_version(self):
    #    stdout, stderr = self.run_command('version')

    #def get_bconsole_version(self):
    #    stdout, stderr = self.run_command('@version')
