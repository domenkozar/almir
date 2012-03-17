"""Dirty script to output buildout.cfg, but it does the job.
"""
import os
import getpass


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


def main():
    print '\n\nConfiguring almir ...'
    print 'If you want to use the default, press enter.'
    print ''

    options = {}
    # TODO: validation: int, address, engine, timezone, mustprovide
    options['host'] = raw_input('Host to listen on (default: 127.0.0.1): ') or '127.0.0.1'
    options['port'] = raw_input('Port to listen on (default: 2500): ') or '2500'
    print 'explain engines, examples'
    options['engine'] = raw_input('SQLAlchemy engine: ')
    options['timezone'] = raw_input('Timezone (defaults to system timezone): ') or ''
    print 'explain engines, examples'
    options['director_name'] = raw_input('Name of director to connect to (default: localhost-dir): ') or 'localhost-dir'
    options['director_address'] = raw_input('Address of director to connect to (default: localhost): ') or 'localhost'
    options['director_port'] = raw_input('Port of director to connect to (default: 9101): ') or '9101'
    options['director_password'] = getpass.getpass('Password of director to connect to: ')

    with open(OUTPUT, 'w') as f:
        f.write(TEMPLATE % options)

if __name__ == '__main__':
    main()
