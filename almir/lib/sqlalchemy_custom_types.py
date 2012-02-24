import sqlalchemy.types as types
from sqlalchemy.dialects.sqlite import DATETIME


class BaculaDateTime(types.TypeDecorator):
    '''Changes sqlite DateTime to parse 0 values correctly'''

    impl = types.DateTime

    def result_processor(self, dialect, coltype):
        # TODO: currently the type is not used when doing request to /job
        # http://docs.sqlalchemy.org/en/latest/core/types.html?highlight=typedecorator#sqlalchemy.types.TypeDecorator
        # http://docs.sqlalchemy.org/en/latest/dialects/sqlite.html#sqlalchemy.dialects.sqlite.DATETIME
        if dialect == 'sqlite':
            import pdb;pdb.set_trace()
