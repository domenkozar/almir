# taken from https://bitbucket.org/zzzeek/sqlalchemy/src/3b458030a0f3/examples/declarative_reflection/declarative_reflection.py
from sqlalchemy import *
from sqlalchemy.orm import *
from sqlalchemy.orm.util import _is_mapped_class
from sqlalchemy.ext.declarative import declarative_base, declared_attr


class DeclarativeReflectedBase(object):
    _mapper_args = []

    @classmethod
    def __mapper_cls__(cls, *args, **kw):
        """Declarative will use this function in lieu of
        calling mapper() directly.

        Collect each series of arguments and invoke
        them when prepare() is called.
        """

        cls._mapper_args.append((args, kw))

    @classmethod
    def prepare(cls, engine):
        """Reflect all the tables and map !"""
        while cls._mapper_args:
            args, kw = cls._mapper_args.pop()
            klass = args[0]
            # autoload Table, which is already
            # present in the metadata.  This
            # will fill in db-loaded columns
            # into the existing Table object.
            if args[1] is not None:
                table = args[1]
                Table(table.name,
                    cls.metadata,
                    extend_existing=True,
                    autoload_replace=False,
                    autoload=True,
                    autoload_with=engine,
                    schema=table.schema)

            # see if we need 'inherits' in the
            # mapper args.  Declarative will have
            # skipped this since mappings weren't
            # available yet.
            for c in klass.__bases__:
                if _is_mapped_class(c):  # pragma: nocover
                    kw['inherits'] = c
                    break

            klass.__mapper__ = mapper(*args, **kw)
