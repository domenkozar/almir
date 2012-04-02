import functools
import unittest2

from pyramid import testing
from sqlalchemy import event
from sqlalchemy.engine import Engine


def assert_num_of_queries(num_of_queries, **dbs):
    def dec(func):
        @functools.wraps(func)
        def wrapper(*a, **kw):
            self = a[0]
            num_of_q = dbs.get(self.database, num_of_queries)
            before = self.num_of_sql_queries
            func(*a, **kw)
            after = self.num_of_sql_queries
            self.assertEqual(after - before, num_of_q, "%s: Expected %d queries, got %d (on %s)" % (func.__name__, num_of_q, after - before, self.database))
        return wrapper
    return dec


class AlmirTestCase(unittest2.TestCase):

    @classmethod
    def setUpClass(cls):
        cls.config = testing.setUp()

        # prepare query counting
        cls.num_of_sql_queries = 0
        event.listen(Engine, "after_cursor_execute", cls.count_query)

    @classmethod
    def tearDown(cls):
        testing.tearDown()

    @classmethod
    def count_query(cls, *a, **kw):
        cls.num_of_sql_queries += 1
