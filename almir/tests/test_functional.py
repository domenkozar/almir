import os
import urlparse
from subprocess import Popen, PIPE

from mock import patch
from paste.deploy.loadwsgi import appconfig
from webtest import TestApp

from almir import main
from almir.tests import AlmirTestCase, assert_num_of_queries


here = os.path.dirname(__file__)


class FunctionalTests(AlmirTestCase):
    """Runs tests under multiple datasets"""
    settings = appconfig('config:' + os.path.join(here, '../../', 'development.ini'))
    db_conns = {
        'sqlite': 'sqlite:///bacula_kaki.db',
        'mysql': 'mysql+mysqlconnector://root@localhost/bacula',
        'postgresql': 'postgresql+pg8000://postgres@localhost/bacula',
    }
    database = os.environ.get('DATABASE', 'sqlite')

    @classmethod
    def setUpClass(cls):
        super(FunctionalTests, cls).setUpClass()
        engine = os.environ.get('ENGINE', '')

        if engine:  # PRAGMA: no cover
            cls.settings['sqlalchemy.url'] = engine
            cls.database = urlparse.urlparse(engine).scheme.split('+')[0]
        else:
            cls.settings['sqlalchemy.url'] = cls.db_conns[cls.database]

        cls.app = main({}, **cls.settings)
        cls.testapp = TestApp(cls.app)

    @assert_num_of_queries(8, mysql=7, postgresql=7)
    @patch('almir.lib.bconsole.BConsole.start_process')
    def test_root(self, mock_process):
        mock_process.return_value = Popen(['cat'], stdout=PIPE, stdin=PIPE, stderr=PIPE)

        res = self.testapp.get('/', status=200)
        self.failUnless('Last finished Jobs' in res.body)
        self.failUnless('Running Jobs' in res.body)

    @assert_num_of_queries(0)
    def test_about(self):
        res = self.testapp.get('/about/', status=200)
        self.failUnless('Domen' in res.body)

    @assert_num_of_queries(1)
    def test_logs(self):
        res = self.testapp.get('/log/', status=200)
        self.failUnless('Log' in res.body)

    @assert_num_of_queries(0)
    def test_console(self):
        res = self.testapp.get('/console/', status=200)
        self.failUnless('Console' in res.body)

    @assert_num_of_queries(0)
    @patch('almir.lib.bconsole.BConsole.start_process')
    def test_console_ajax(self, mock_process):
        mock_process.return_value = Popen(['cat'], stdout=PIPE, stdin=PIPE, stderr=PIPE)

        res = self.testapp.post('/console/input/', {'bconsole_command': 'version'}, status=200)
        self.assertTrue('commands' in res.body)

        res = self.testapp.post('/console/input/', {'bconsole_command': ''}, status=200)
        self.assertTrue('commands' in res.body)

# restful

    @assert_num_of_queries(1)
    def test_restful_404(self):
        self.testapp.get('/client/9999/', status=404)

    @assert_num_of_queries(0)
    def test_append_slash(self):
        res = self.testapp.get('/about', status=302)
        res.follow(status=200)

    @assert_num_of_queries(1)
    def test_jobs(self):
        res = self.testapp.get('/job/', status=200)
        self.failUnless('Jobs' in res.body)

    @assert_num_of_queries(1)
    def test_job(self):
        ids = {
               'sqlite': 15,
        }
        id_ = ids.get(self.database, 1)
        res = self.testapp.get('/job/%d/' % id_, status=200)
        self.failUnless('Log' in res.body)

    @assert_num_of_queries(1)
    def test_clients(self):
        res = self.testapp.get('/client/', status=200)
        self.failUnless('Clients' in res.body)

    @assert_num_of_queries(4)
    def test_client(self):
        res = self.testapp.get('/client/1/', status=200)
        self.failUnless('Log' in res.body)

    @assert_num_of_queries(1)
    def test_storages(self):
        res = self.testapp.get('/storage/', status=200)
        self.failUnless('Storage' in res.body)

    @assert_num_of_queries(1)
    def test_storage(self):
        res = self.testapp.get('/storage/1/', status=200)
        self.failUnless('Storage' in res.body)

    @assert_num_of_queries(1)
    def test_volumes(self):
        res = self.testapp.get('/volume/', status=200)
        self.failUnless('Volumes' in res.body)

    @assert_num_of_queries(1)
    def test_volume(self):
        res = self.testapp.get('/volume/1/', status=200)
        self.failUnless('Volume' in res.body)

    @assert_num_of_queries(1)
    def test_pools(self):
        res = self.testapp.get('/pool/', status=200)
        self.failUnless('Pools' in res.body)

    @assert_num_of_queries(1)
    def test_pool(self):
        res = self.testapp.get('/pool/1/', status=200)
        self.failUnless('Pool' in res.body)


if os.environ.get('ALL_DATABASES', ''):
    MySQLFunctionalTests = type('MySQLFunctionalTests', (FunctionalTests,), {'database': 'mysql'})
    PGFunctionalTests = type('PGFunctionalTests', (FunctionalTests,), {'database': 'postgresql'})
