import os.path
import pickle
import logging
import hashlib
import sqlite3

from pyramid.httpexceptions import exception_response
from sqlalchemy import engine_from_config
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.ext.declarative import declared_attr
from sqlalchemy.orm import scoped_session
from sqlalchemy.orm import sessionmaker
from zope.sqlalchemy import ZopeTransactionExtension

from almir.lib.sqlalchemy_declarative_reflection import DeclarativeReflectedBase
from almir.lib.sqlalchemy_lowercase_inspector import LowerCaseInspector
from almir.lib.filters import format_byte_size


log = logging.getLogger(__name__)


def readonly_flush(*a, **kw):
    print 'readonly session, there should be no writes to DB'

DBSession = scoped_session(sessionmaker(extension=ZopeTransactionExtension()))
DBSession.flush = readonly_flush
Base = declarative_base(cls=DeclarativeReflectedBase)


class ModelMixin(object):
    query = DBSession.query_property()

    @declared_attr
    def __tablename__(cls):
        return cls.__name__.lower()

    @classmethod
    def objects_list(cls):
        return {'objects': cls.query}

    @classmethod
    def object_detail(cls, id_):
        obj = cls.query.get(int(id_))
        if obj == None:
            raise exception_response(404)
        else:
            return {'object': obj}

    @staticmethod
    def format_byte_size(size):
        # we use float since postgres driver will return decimal
        return format_byte_size(float(size))


def initialize_sql(settings):
    # make sure metadata is populated
    import almir.models

    engine = engine_from_config(settings, prefix='sqlalchemy.')

    # monkey patch inspector to reflect lowercase tables/columns since sqlite has mixed case
    # while postgres has lowercase tables/columns
    engine.dialect.inspector = LowerCaseInspector

    # hash engine paramters so we don't cache wrong metadata
    engine_hash = hashlib.md5(str(engine.url)).hexdigest()
    DBSession.configure(bind=engine)

    # cache (pickle) metadata
    Base.prepare(engine)

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
