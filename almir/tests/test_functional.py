import unittest2
import os
from subprocess import Popen, PIPE

from mock import patch
from paste.deploy.loadwsgi import appconfig
from pyramid import testing
from webtest import TestApp

from almir import main


here = os.path.dirname(__file__)


class AlmirTestCase(unittest2.TestCase):
    settings = appconfig('config:' + os.path.join(here, '../../', 'development.ini'))

    @classmethod
    def setUpClass(cls):
        testing.setUp()

    @classmethod
    def tearDown(cls):
        testing.tearDown()


# TODO: test all db

class FunctionalTests(AlmirTestCase):

    @classmethod
    def setUpClass(cls):
        super(FunctionalTests, cls).setUpClass()
        cls.app = main({}, **cls.settings)
        cls.testapp = TestApp(cls.app)

    @patch('almir.lib.bconsole.BConsole.start_process')
    def test_root(self, mock_process):
        mock_process.return_value = Popen(['cat'], stdout=PIPE, stdin=PIPE, stderr=PIPE)

        res = self.testapp.get('/', status=200)
        self.failUnless('Last finished Jobs' in res.body)
        self.failUnless('Running Jobs' in res.body)

    def test_about(self):
        res = self.testapp.get('/about/', status=200)
        self.failUnless('Domen' in res.body)

    def test_logs(self):
        res = self.testapp.get('/log/', status=200)
        self.failUnless('Log' in res.body)

    def test_console(self):
        res = self.testapp.get('/console/', status=200)
        self.failUnless('Console' in res.body)

    @patch('almir.lib.bconsole.BConsole.start_process')
    def test_console_ajax(self, mock_process):
        mock_process.return_value = Popen(['cat'], stdout=PIPE, stdin=PIPE, stderr=PIPE)

        res = self.testapp.post('/console/input/', {'bconsole_command': 'version'}, status=200)
        self.assertTrue('commands' in res.body)

        res = self.testapp.post('/console/input/', {'bconsole_command': ''}, status=200)
        self.assertTrue('commands' in res.body)

# restful

    def test_restful_404(self):
        self.testapp.get('/client/9999/', status=404)

    def test_append_slash(self):
        res = self.testapp.get('/client', status=302)
        res.follow(status=200)

    def test_jobs(self):
        res = self.testapp.get('/job/', status=200)
        self.failUnless('Jobs' in res.body)

    def test_job(self):
        res = self.testapp.get('/job/8/', status=200)
        self.failUnless('Log' in res.body)

    def test_clients(self):
        res = self.testapp.get('/client/', status=200)
        self.failUnless('Clients' in res.body)

    def test_client(self):
        res = self.testapp.get('/client/1/', status=200)
        self.failUnless('Log' in res.body)

    def test_storages(self):
        res = self.testapp.get('/storage/', status=200)
        self.failUnless('Storage' in res.body)

    def test_storage(self):
        res = self.testapp.get('/storage/1/', status=200)
        self.failUnless('Storage' in res.body)

    def test_volumes(self):
        res = self.testapp.get('/volume/', status=200)
        self.failUnless('Volumes' in res.body)

    def test_volume(self):
        res = self.testapp.get('/volume/1/', status=200)
        self.failUnless('Volume' in res.body)

    def test_pools(self):
        res = self.testapp.get('/pool/', status=200)
        self.failUnless('Pools' in res.body)

    def test_pool(self):
        res = self.testapp.get('/pool/1/', status=200)
        self.failUnless('Pool' in res.body)
