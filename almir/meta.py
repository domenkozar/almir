#import os.path
#import pickle
import logging
#import hashlib
#import sqlite3
from datetime import datetime

from pyramid.httpexceptions import exception_response
from sqlalchemy import engine_from_config
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.ext.declarative import declared_attr
from sqlalchemy.orm import scoped_session
from sqlalchemy.orm import sessionmaker
from zope.sqlalchemy import ZopeTransactionExtension
from webhelpers.date import distance_of_time_in_words
from webhelpers.number import format_byte_size

from almir.lib.sqlalchemy_declarative_reflection import DeclarativeReflectedBase
from almir.lib.sqlalchemy_lowercase_inspector import LowerCaseInspector
from almir.lib.utils import timedelta_to_seconds, convert_timezone


log = logging.getLogger(__name__)

DBSession = scoped_session(sessionmaker(extension=ZopeTransactionExtension()))
Base = declarative_base(cls=DeclarativeReflectedBase)


class ModelMixin(object):
    query = DBSession.query_property()

    @declared_attr
    def __tablename__(cls):
        if cls.metadata.bind and cls.metadata.bind.dialect.name == 'postgresql':  # PRAGMA: no cover
            return cls.__name__.lower()
        else:
            return cls.__name__

    @classmethod
    def get_list(cls, **kw):
        return cls.query

    @classmethod
    def get_one(cls, id_=None, query=None):
        if id_ is not None:
            query = cls.query.get(int(id_))

        if query == None:
            raise exception_response(404)
        else:
            return query

    @staticmethod
    def format_byte_size(size):
        if size:
            # we use float since postgres driver will return decimal
            return format_byte_size(float(size))
        else:
            return format_byte_size(0)

    @staticmethod
    def render_distance_of_time_in_words(dt_from, dt_to=None):
        if not dt_from:
            return

        if dt_from.tzinfo is None:
            dt_from = convert_timezone(dt_from)

        if dt_to is None:
            return {'text': distance_of_time_in_words(dt_from, convert_timezone(datetime.now())) + ' ago', 'data_numeric': dt_from.strftime('%s')}
        else:
            if dt_to.tzinfo is None:
                dt_to = convert_timezone(dt_to)
            return {'text': distance_of_time_in_words(dt_from, dt_to),
                    'data_numeric': -timedelta_to_seconds(dt_to - dt_from)}


# TODO: cache for 5min
def get_database_size(engine):
    """Returns human formatted SQL database size.

    Example: 3.04 GB
    """
    if engine.name == 'sqlite':
        size_bytes = engine.execute('PRAGMA page_count;').scalar() * engine.execute('PRAGMA page_size;').scalar()
    elif engine.name == 'mysql':
        size_bytes = engine.execute('SELECT sum(ROUND((DATA_LENGTH + INDEX_LENGTH),2)) AS Size '
                                    'FROM INFORMATION_SCHEMA.TABLES where TABLE_SCHEMA like "%s";' % engine.url.database).scalar()
    elif engine.name == 'postgresql':
        size_bytes = engine.execute('SELECT pg_database_size(\'%s\');' % engine.url.database).scalar()
    else:
        raise NotImplemented
    return format_byte_size(float(size_bytes))


def initialize_sql(settings):
    # make sure metadata is populated

    engine = engine_from_config(settings, prefix='sqlalchemy.', encoding='utf-8')

    # monkey patch inspector to reflect lowercase tables/columns since sqlite/mysql have mixed case
    # while postgres has lowercase tables/columns
    engine.dialect.inspector = LowerCaseInspector

    DBSession.configure(bind=engine)
    DBSession.bind = engine
    Base.metadata.bind = engine

    import almir.models

    # cache (pickle) metadata
    Base.prepare(engine)

    # hash engine paramters so we don't cache wrong metadata
    #engine_hash = hashlib.md5(str(engine.url)).hexdigest()
    # TODO: figure out a way for sqlalchemy_declarative_reflection to work with metadata caching
    # TODO: configure with .ini
    #cachefile = os.path.join(os.path.dirname(__name__), 'db.metada.cache.%s' % engine_hash)
    #if os.path.isfile(cachefile):
    #    log.info('Loading database schema from cache file: %s', cachefile)
    #with open(cachefile, 'r') as cache:
    #Base.metadata = pickle.load(cache)
    #else:
    #log.info('Generating database schema cache file: %s', cachefile)
    #    with open(cachefile, 'w') as cache:
    #        pickle.dump(Base.metadata, cache)
