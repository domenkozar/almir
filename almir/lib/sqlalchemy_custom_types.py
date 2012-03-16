import datetime
import re

import sqlalchemy.types as types

from almir.lib.utils import convert_timezone

DATETIME_RE = re.compile("(\d+)-(\d+)-(\d+) (\d+):(\d+):(\d+)(?:\.(\d+))?")


class BaculaDateTime(types.TypeDecorator):
    '''Changes sqlite DateTime to parse 0 values as no value. Also converts to right timezone'''

    impl = types.DateTime

    def process_result_value(self, value, dialect=None):
        return convert_timezone(value)

    def result_processor(self, dialect, coltype):
        if dialect.name == 'sqlite':
            # http://docs.sqlalchemy.org/en/latest/core/types.html?highlight=typedecorator#sqlalchemy.types.TypeDecorator
            # http://docs.sqlalchemy.org/en/latest/dialects/sqlite.html#sqlalchemy.dialects.sqlite.DATETIME
            # https://bitbucket.org/zzzeek/sqlalchemy/src/3b458030a0f3/lib/sqlalchemy/dialects/sqlite/base.py
            def process(value):
                # if we have value as 0, that should be None
                if not value:
                    return None
                else:
                    try:
                        m = DATETIME_RE.match(value)
                    except TypeError:
                        raise ValueError("Couldn't parse %s string '%r' "
                                        "- value is not a string." % (datetime.datetime_.__name__, value))
                    if m is None:
                        raise ValueError("Couldn't parse %s string: "
                                        "'%s'" % (datetime.datetime.__name__, value))
                    return self.process_result_value(datetime.datetime(*map(int, m.groups(0))))
            return process
        else:
            return super(BaculaDateTime, self).result_processor(dialect, coltype)
