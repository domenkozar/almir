import os
import urlparse
import json
import logging.config
from subprocess import Popen, PIPE

from mock import patch
from paste.deploy.loadwsgi import appconfig
from webtest import TestApp

from almir import main
from almir.tests import AlmirTestCase, assert_num_of_queries


here = os.path.dirname(__file__)


class FunctionalTests(AlmirTestCase):
    """Runs tests under multiple datasets"""
    config_file = os.path.join(here, '../../', 'testing.ini')
    settings = appconfig('config:' + config_file)
    db_conns = {
        'sqlite': 'sqlite:///%s' % os.path.join(here, 'fixtures', 'sqlite.db'),
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
        logging.config.fileConfig(cls.config_file)

    @assert_num_of_queries(8, mysql=7, postgresql=7)
    @patch('almir.lib.bconsole.BConsole.start_process')
    @patch('almir.lib.bconsole.BConsole.get_version')
    def test_root(self, mock_get_version, mock_process):
        mock_process.return_value = Popen(['cat'], stdout=PIPE, stdin=PIPE, stderr=PIPE)

        res = self.testapp.get('/', status=200)
        self.failUnless('Last 5 finished Jobs' in res.body)
        self.failUnless('Running Jobs' in res.body)

    @assert_num_of_queries(0)
    def test_about(self):
        res = self.testapp.get('/about/', status=200)
        self.failUnless('Domen' in res.body)

    @assert_num_of_queries(0)
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

    @assert_num_of_queries(3)
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

    @assert_num_of_queries(4)
    def test_datatables_jobs(self):
        params = {
            "sEcho": "1",
            "iColumns": "9",
            "sColumns": "jobid,status.joblongstatus,,,,client.clientid,,,",
            "iDisplayStart": "0",
            "iDisplayLength": "50",
            "mDataProp_0": "name",
            "mDataProp_1": "status",
            "mDataProp_2": "type",
            "mDataProp_3": "level",
            "mDataProp_4": "jobfiles",
            "mDataProp_5": "client_name",
            "mDataProp_6": "starttime",
            "mDataProp_7": "duration",
            "mDataProp_8": "joberrors",
            "sSearch": "",
            "bRegex": "false",
            "sSearch_0": "",
            "bRegex_0": "false",
            "bSearchable_0": "true",
            "sSearch_1": "",
            "bRegex_1": "false",
            "bSearchable_1": "true",
            "sSearch_2": "",
            "bRegex_2": "false",
            "bSearchable_2": "true",
            "sSearch_3": "",
            "bRegex_3": "false",
            "bSearchable_3": "true",
            "sSearch_4": "",
            "bRegex_4": "false",
            "bSearchable_4": "true",
            "sSearch_5": "",
            "bRegex_5": "false",
            "bSearchable_5": "true",
            "sSearch_6": "",
            "bRegex_6": "false",
            "bSearchable_6": "true",
            "sSearch_7": "",
            "bRegex_7": "false",
            "bSearchable_7": "false",
            "sSearch_8": "",
            "bRegex_8": "false",
            "bSearchable_8": "true",
            "iSortingCols": "1",
            "iSortCol_0": "6",
            "sSortDir_0": "desc",
            "bSortable_0": "true",
            "bSortable_1": "true",
            "bSortable_2": "true",
            "bSortable_3": "true",
            "bSortable_4": "true",
            "bSortable_5": "true",
            "bSortable_6": "true",
            "bSortable_7": "false",
            "bSortable_8": "true",
            "referrer": "/job/",
            "_charset_": "",
            "__formid__": "deform",
            "state": "finished+running",
            "type": "",
            "status": "",
        }
        res = self.testapp.get('/datatables/', params, status=200)
        self.assertTrue(res.json)

        d = json.loads(res.body)
        self.assertEqual(d['sEcho'], 1)
        self.assertEqual(d['iTotalDisplayRecords'], d['iTotalRecords'])
        self.assertEqual(d['iTotalDisplayRecords'], len(d['aaData']))

    @assert_num_of_queries(4)
    def test_datatables_jobs_form(self):
        params = {
            "sEcho": "1",
            "iColumns": "9",
            "sColumns": "jobid,status.joblongstatus,,,,client.clientid,,,",
            "iDisplayStart": "0",
            "iDisplayLength": "50",
            "mDataProp_0": "name",
            "mDataProp_1": "status",
            "mDataProp_2": "type",
            "mDataProp_3": "level",
            "mDataProp_4": "jobfiles",
            "mDataProp_5": "client_name",
            "mDataProp_6": "starttime",
            "mDataProp_7": "duration",
            "mDataProp_8": "joberrors",
            "sSearch": "",
            "bRegex": "false",
            "sSearch_0": "",
            "bRegex_0": "false",
            "bSearchable_0": "true",
            "sSearch_1": "",
            "bRegex_1": "false",
            "bSearchable_1": "true",
            "sSearch_2": "",
            "bRegex_2": "false",
            "bSearchable_2": "true",
            "sSearch_3": "",
            "bRegex_3": "false",
            "bSearchable_3": "true",
            "sSearch_4": "",
            "bRegex_4": "false",
            "bSearchable_4": "true",
            "sSearch_5": "",
            "bRegex_5": "false",
            "bSearchable_5": "true",
            "sSearch_6": "",
            "bRegex_6": "false",
            "bSearchable_6": "true",
            "sSearch_7": "",
            "bRegex_7": "false",
            "bSearchable_7": "false",
            "sSearch_8": "",
            "bRegex_8": "false",
            "bSearchable_8": "true",
            "iSortingCols": "1",
            "iSortCol_0": "6",
            "sSortDir_0": "desc",
            "bSortable_0": "true",
            "bSortable_1": "true",
            "bSortable_2": "true",
            "bSortable_3": "true",
            "bSortable_4": "true",
            "bSortable_5": "true",
            "bSortable_6": "true",
            "bSortable_7": "false",
            "bSortable_8": "true",
            "referrer": "/job/",
            "_charset_": "",
            "__formid__": "deform",
            "state": "finished+running",
            "type": "R",
            "status": "C",
        }
        res = self.testapp.get('/datatables/', params, status=200)
        self.assertTrue(res.json)

        d = json.loads(res.body)
        self.assertEqual(d['sEcho'], 1)
        self.assertEqual(d['iTotalRecords'], 0)
        self.assertEqual(len(d['aaData']), 0)

    @assert_num_of_queries(4)
    def test_datatables_files(self):
        ids = {
               'sqlite': 15,
        }
        id_ = ids.get(self.database, 1)
        params = {
            "sEcho": "1",
            "iColumns": "5",
            "sColumns": "path.path;filename.name,,,,",
            "iDisplayStart": "0",
            "iDisplayLength": "50",
            "mDataProp_0": "filename",
            "mDataProp_1": "size",
            "mDataProp_2": "mode",
            "mDataProp_3": "uid",
            "mDataProp_4": "gid",
            "sSearch": "",
            "bRegex": "false",
            "sSearch_0": "",
            "bRegex_0": "false",
            "bSearchable_0": "true",
            "sSearch_1": "",
            "bRegex_1": "false",
            "bSearchable_1": "false",
            "sSearch_2": "",
            "bRegex_2": "false",
            "bSearchable_2": "false",
            "sSearch_3": "",
            "bRegex_3": "false",
            "bSearchable_3": "false",
            "sSearch_4": "",
            "bRegex_4": "false",
            "bSearchable_4": "false",
            "iSortingCols": "1",
            "iSortCol_0": "0",
            "sSortDir_0": "asc",
            "bSortable_0": "true",
            "bSortable_1": "false",
            "bSortable_2": "false",
            "bSortable_3": "false",
            "bSortable_4": "false",
            "referrer": "/job/%d/" % id_,
            "context": "files",
        }
        res = self.testapp.get('/datatables/', params, status=200)
        self.assertTrue(res.json)

        d = json.loads(res.body)
        self.assertEqual(d['sEcho'], 1)
        self.assertEqual(d['iTotalDisplayRecords'], d['iTotalRecords'])
        self.assertEqual(d['iTotalDisplayRecords'], len(d['aaData']))

    @assert_num_of_queries(4)
    def test_datatables_files_search(self):
        ids = {
               'sqlite': 15,
        }
        id_ = ids.get(self.database, 1)
        params = {
            "sEcho": "1",
            "iColumns": "5",
            "sColumns": "path.path;filename.name,,,,",
            "iDisplayStart": "0",
            "iDisplayLength": "50",
            "mDataProp_0": "filename",
            "mDataProp_1": "size",
            "mDataProp_2": "mode",
            "mDataProp_3": "uid",
            "mDataProp_4": "gid",
            "sSearch": "blablabla",
            "bRegex": "false",
            "sSearch_0": "",
            "bRegex_0": "false",
            "bSearchable_0": "true",
            "sSearch_1": "",
            "bRegex_1": "false",
            "bSearchable_1": "false",
            "sSearch_2": "",
            "bRegex_2": "false",
            "bSearchable_2": "false",
            "sSearch_3": "",
            "bRegex_3": "false",
            "bSearchable_3": "false",
            "sSearch_4": "",
            "bRegex_4": "false",
            "bSearchable_4": "false",
            "iSortingCols": "1",
            "iSortCol_0": "0",
            "sSortDir_0": "asc",
            "bSortable_0": "true",
            "bSortable_1": "false",
            "bSortable_2": "false",
            "bSortable_3": "false",
            "bSortable_4": "false",
            "referrer": "/job/%d/" % id_,
            "context": "files",
        }
        res = self.testapp.get('/datatables/', params, status=200)
        self.assertTrue(res.json)

        d = json.loads(res.body)
        self.assertEqual(d['sEcho'], 1)
        self.assertEqual(d['iTotalDisplayRecords'], len(d['aaData']))
        self.assertEqual(len(d['aaData']), 0)

    @assert_num_of_queries(3)
    def test_datatables_logs(self):
        params = {
            "sEcho": "1",
            "iColumns": "3",
            "sColumns": "",
            "iDisplayStart": "0",
            "iDisplayLength": "1",
            "mDataProp_0": "jobid",
            "mDataProp_1": "time",
            "mDataProp_2": "logtext",
            "sSearch": "Found to prune",
            "bRegex": "false",
            "sSearch_0": "",
            "bRegex_0": "false",
            "bSearchable_0": "true",
            "sSearch_1": "",
            "bRegex_1": "false",
            "bSearchable_1": "false",
            "sSearch_2": "",
            "bRegex_2": "false",
            "bSearchable_2": "true",
            "iSortingCols": "1",
            "iSortCol_0": "1",
            "sSortDir_0": "desc",
            "bSortable_0": "true",
            "bSortable_1": "true",
            "bSortable_2": "true",
            "referrer": "/log/",
        }
        res = self.testapp.get('/datatables/', params, status=200)
        self.assertTrue(res.json)

        d = json.loads(res.body)
        self.assertEqual(d['sEcho'], 1)
        self.assertNotEqual(d['iTotalDisplayRecords'], d['iTotalRecords'])
        self.assertNotEqual(d['iTotalDisplayRecords'], len(d['aaData']))


if os.environ.get('ALL_DATABASES', ''):  # PRAGMA: no coverage
    MySQLFunctionalTests = type('MySQLFunctionalTests', (FunctionalTests,), {'database': 'mysql'})
    PGFunctionalTests = type('PGFunctionalTests', (FunctionalTests,), {'database': 'postgresql'})
