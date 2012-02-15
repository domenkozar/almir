import unittest
import os

from paste.deploy.loadwsgi import appconfig
from webtest import TestApp

from almir import main


here = os.path.dirname(__file__)
settings = appconfig('config:' + os.path.join(here, '../../', 'development.ini'))


#class TestMyView(unittest.TestCase):
#    def setUp(self):
#        self.config = testing.setUp()

#    def tearDown(self):
#        testing.tearDown()

#    def test_dashboard(self):
#        request = testing.DummyRequest()
#        info = views.dashboard(request)

# TODO: fixtures

class FunctionalTests(unittest.TestCase):
    def setUp(self):
        app = main({}, **settings)
        self.testapp = TestApp(app)

    def test_root(self):
        res = self.testapp.get('/', status=200)
        self.failUnless('Latests Jobs' in res.body)

    def test_about(self):
        res = self.testapp.get('/about', status=200)
        self.failUnless('About' in res.body)

    def test_logs(self):
        res = self.testapp.get('/log', status=200)
        self.failUnless('Log' in res.body)

    def test_console(self):
        res = self.testapp.get('/console', status=200)
        self.failUnless('Console' in res.body)

    def test_console_ajax(self):
        res = self.testapp.post('/console/ajax', {'bconsole_command': 'version'}, status=200)
        self.failUnless('OK' in res.body)

# restful

    def test_restful_404(self):
        self.testapp.get('/client/9999', status=404)

    def test_jobs(self):
        res = self.testapp.get('/job', status=200)
        self.failUnless('Jobs' in res.body)

    def test_job(self):
        res = self.testapp.get('/job/3338', status=200)
        self.failUnless('Log' in res.body)

    def test_clients(self):
        res = self.testapp.get('/client', status=200)
        self.failUnless('Clients' in res.body)

    def test_client(self):
        res = self.testapp.get('/client/1', status=200)
        self.failUnless('Log' in res.body)

    def test_storages(self):
        res = self.testapp.get('/storage', status=200)
        self.failUnless('Storage' in res.body)

    def test_storage(self):
        res = self.testapp.get('/storage/1', status=200)
        self.failUnless('Storage' in res.body)

    def test_volumes(self):
        res = self.testapp.get('/volume', status=200)
        self.failUnless('Volumes' in res.body)

    def test_volume(self):
        res = self.testapp.get('/volume/124', status=200)
        self.failUnless('Volume' in res.body)

    def test_pools(self):
        res = self.testapp.get('/pool', status=200)
        self.failUnless('Pools' in res.body)

    def test_pool(self):
        res = self.testapp.get('/pool/1', status=200)
        self.failUnless('Pool' in res.body)
