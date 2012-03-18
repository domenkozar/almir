"""Dirty script to output buildout.cfg, but it does the job.
"""
import os
import re
import getpass
import socket


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
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    try:
        s.bind(('', int(v)))
        # port is open
    except Exception, e:
        raise ValueError('Cannot listen on port %s: %s' % (v, e.message))
    finally:
        s.close()


def validate_int(v):
    try:
        int(v)
    except ValueError:
        raise ValueError('Must be an integer!')


def validate_engine(v):
    pass
    # TODO: connect to database to verify parameters (tricky, sqlalchemy not importable here)


def validate_timezone(v):
    # TODO: use pytz to validate timezone
    match = re.match(r'[a-zA-Z_ ]+/[a-zA-Z_ ]+|[A-Z]+', v)
    if not match:
        raise ValueError('Incorrect timezone format, should be like Continent/City or CET')


def ask_question(question, default=None, validator=None, func=raw_input):
    good_answer = None

    while good_answer is None:
        answer = func(question)

        if validator and answer:
            try:
                validator(answer)
            except ValueError as e:
                print '    Try again: ' + e.message
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

    print 'Define SQL database connection as specified in http://docs.sqlalchemy.org/en/latest/core/engines.html#database-urls'
    print 'For example:'
    print '    postgresql+pg8000://bacula:<password>@hostname/<database>'
    print '    mysql+mysqlconnector://bacula:<password>@hostname/<database>'
    print '    sqlite:///var/lib/bacula/bacula.db'
    print
    options['engine'] = ask_question('SQL connection string: ', validator=validate_engine)

    print 'Timezone of director in format of TZ* column in table https://en.wikipedia.org/wiki/List_of_tz_database_time_zones'
    print 'For example:'
    print '    Europe/Ljubljana'
    print '    CET'
    print
    options['timezone'] = ask_question('Timezone (defaults to system timezone): ', default='', validator=validate_timezone)

    # TODO: in future we may extract this from config file?
    print 'Almost finished, we just need bconsole parameters to connect to director!'
    options['director_name'] = ask_question('Name of director to connect to (default: localhost-dir): ', default='localhost-dir')
    options['director_address'] = ask_question('Address of director to connect to (default: localhost): ', default='localhost')
    options['director_port'] = ask_question('Port of director to connect to (default: 9101): ', default='9101', validator=validate_open_port)
    options['director_password'] = ask_question('Password of director to connect to: ', func=getpass.getpass)
    # TODO: test bconsole connectivity (we don't have almir installed yet, this one is tricky.)

    with open(OUTPUT, 'w') as f:
        f.write(TEMPLATE % options)

    print 'Written to %s.' % os.path.realpath(OUTPUT)


if __name__ == '__main__':
    main()
