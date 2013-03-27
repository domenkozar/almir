"""Dirty script to output buildout.cfg, but it does the job.
"""
import os
import getpass
import socket
import subprocess
import time
try:
    import readline
except ImportError:
    pass
else:
    readline  # pyflakes: we import readline and raw_input has history!

import pytz
import sqlalchemy

from almir.lib.bconsole import BConsole


ROOT = os.path.join(os.path.dirname(__file__), '..', '..')
OUTPUT = os.path.join(ROOT, 'buildout.cfg')
TEMPLATE = """
[buildout]
extends = buildout.d/production.cfg

[almir]
# define sql database connection as specified in
# http://docs.sqlalchemy.org/en/latest/core/engines.html#database-urls
#sqla_engine_url = sqlite:///%%(here)s/bacula.db
#sqla_engine_url = postgresql+pg8000://bacula:<password>@hostname/<database>
#sqla_engine_url = mysql+mysqlconnector://bacula:<password>@hostname/<database>
sqla_engine_url = %(engine)s

# your timezone from TZ* column in table https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
# if not set, defaults to system timezone
#timezone = Europe/Ljubljana
timezone = %(timezone)s

# configure http daemon
host = %(host)s
port = %(port)s

# bconsole director parameters
director_name = %(director_name)s
director_port = %(director_port)s
director_address = %(director_address)s
director_password = %(director_password)s
"""


def validate_open_port(v):
    validate_int(v)

    # python2.6 will overflow port integer if it is too big
    if int(v) not in xrange(0, 65536):
        raise ValueError('Cannot listen on port %s: port must be 0-65535.' % v)

    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    try:
        s.bind(('', int(v)))
        # port is open
    except Exception, e:
        raise ValueError('Cannot listen on port %s: %s' % (v, e))
    finally:
        s.close()


def validate_timezone(v):
    try:
        pytz.timezone(v)
    except:
        raise ValueError('Invalid timezone: %s' % v)


def validate_int(v):
    try:
        int(v)
    except ValueError:
        raise ValueError('Must be an integer!')


def validate_engine(v):
    print 'Connecting to catalog database to verify configuration ...'
    try:
        engine = None
        engine = sqlalchemy.create_engine(v)
        if 'client' not in map(lambda e: e.lower(), engine.table_names()):
            raise ValueError('Connection string has wrong parameters (could not connect to catalog database)')  # PRAGMA: no cover
    except:
        if engine and engine.dialect.name == 'sqlite':  # PRAGMA: no cover
            print
            print 'WARNING: Using sqlite, database needs to be readable by %s. Fix is usually:' % getpass.getuser()
            print '$ sudo gpassword -a %s bacula' % getpass.getuser()
            print 'You will need to relogin and restart install procedure, since permission are not updated on the fly'
            print
            # TODO: display file permissions
        raise
    print 'OK!'


def ask_question(question, default=None, validator=None, func=raw_input):
    good_answer = None

    while good_answer is None:
        answer = func("--> " + question)

        if validator and answer:
            try:
                validator(answer)
            except Exception, e:
                print '    Try again: ' + str(e)
                continue

        if answer:
            good_answer = answer
        elif not answer and default is not None:
            good_answer = default
        elif not answer and default is None:
            continue

    # add newline
    print
    return good_answer


def main():
    """Entry point of this script"""
    print '\n\nConfiguring almir ... If you want to use the default value (where possible), press enter.\n'

    options = {}
    options['host'] = ask_question('Host to listen on (default: 127.0.0.1): ', default='127.0.0.1')
    options['port'] = ask_question('Port to listen on (default: 2500): ', default='2500', validator=validate_open_port)

    print 'Define SQL database connection to bacula catalog as specified in http://docs.sqlalchemy.org/en/latest/core/engines.html#database-urls'
    print 'For example:'
    print '    postgresql+pg8000://<user>:<password>@<hostname>/<database>'
    print '    mysql+mysqlconnector://<user>:<password>@<hostname>/<database>'
    print '    sqlite:////var/lib/bacula/bacula.db'
    print '    sqlite:///bacula.db'
    print
    options['engine'] = ask_question('SQL connection string: ', validator=validate_engine)

    print 'Timezone of director in format of TZ* column in table https://en.wikipedia.org/wiki/List_of_tz_database_time_zones'
    print 'For example:'
    print '    Europe/Ljubljana'
    print '    CET'
    print

    try:
        default_timezone = " (default: %s)" % pytz.timezone(time.tzname[0])
    except:
        default_timezone = ''
    options['timezone'] = ask_question('Timezone%s' % default_timezone, default='', validator=validate_timezone)

    # TODO: in future we may extract this from bconsole config file?
    print 'Almost finished, we just need bconsole parameters to connect to director!'
    print 'Normally you will find needed information in /etc/bacula/bconsole.conf'
    print

    try:
        output = subprocess.Popen(['which', 'bconsole'], stdout=subprocess.PIPE).communicate()[0].strip()
    except subprocess.CalledProcessError:
        print 'WARNING: bconsole command is not executable from current user!'
    else:
        if not os.access(output, os.X_OK):
            print 'WARNING: bconsole command is not executable from current user!'

    bconsole_running = False
    while not bconsole_running:
        options['director_name'] = ask_question('Name of director to connect to (default: localhost-dir): ', default='localhost-dir')
        options['director_address'] = ask_question('Address of director to connect to (default: localhost): ', default='localhost')
        options['director_port'] = ask_question('Port of director to connect to (default: 9101): ', default='9101', validator=validate_open_port)
        options['director_password'] = ask_question('Password of director to connect to: ', func=getpass.getpass)

        print 'Connecting director with bconsole to verify configuration ...'

        # need a way to generate bconsole config before running this
        with BConsole.from_temp_config(name=options['director_name'],
                                       address=options['director_address'],
                                       port=options['director_port'],
                                       password=options['director_password']) as bconsole:
            if bconsole.is_running():
                print 'OK!'
                bconsole_running = True
            else:
                print 'ERROR: Could not connect to director %s, verify configuration and try again!' % options['director_name']  # PRAGMA: no cover

    with open(OUTPUT, 'w') as f:
        f.write(TEMPLATE % options)

    print
    print 'Written to %s.' % os.path.realpath(OUTPUT)


if __name__ == '__main__':
    main()  # PRAGMA: no cover
    # TODO: add notes how to proceed if we get an exception
