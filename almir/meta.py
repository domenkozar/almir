import os.path
import pickle
import logging
import hashlib

from pyramid.httpexceptions import exception_response
from psycogreen.gevent.psyco_gevent import make_psycopg_green
from sqlalchemy import engine_from_config
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.ext.declarative import declared_attr
from sqlalchemy.orm import scoped_session
from sqlalchemy.orm import sessionmaker

from zope.sqlalchemy import ZopeTransactionExtension


log = logging.getLogger(__name__)


def readonly_flush(*a, **kw):
    print 'readonly session, there should be no writes to DB'

DBSession = scoped_session(sessionmaker(extension=ZopeTransactionExtension()))
DBSession.flush = readonly_flush
Base = declarative_base()


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
        obj = cls.query.get(id_)
        if obj == None:
            raise exception_response(404)
        else:
            return {'object': obj}


def initialize_sql(settings):
    # TODO: move to post_fork of gunicorn hook
    #make_psycopg_green()
    kw = {'client_encoding': 'utf8'} if 'postgres' in settings.get('sqlalchemy.url', '') else {}
    engine = engine_from_config(settings, prefix='sqlalchemy.', **kw)
    engine_hash = hashlib.md5(str(engine.url)).hexdigest()
    DBSession.configure(bind=engine)

    # cache (pickle) metadata
    # TODO: configure with .ini
    # TODO: using different engine, different metadata is generated (hash)
    cachefile = os.path.join(os.path.dirname(__name__), 'db.metada.cache.%s' % engine_hash)
    if os.path.isfile(cachefile):
        log.info('Loading database schema from cache file: %s', cachefile)
        with open(cachefile, 'r') as cache:
            Base.metadata = pickle.load(cache)
    else:
        Base.metadata.reflect(engine)
        log.info('Generating database schema cache file: %s', cachefile)
        with open(cachefile, 'w') as cache:
            pickle.dump(Base.metadata, cache)
