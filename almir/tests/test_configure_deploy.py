import unittest2

from pyramid import testing
from mock import patch, MagicMock

from almir.scripts.configure_deploy import main


class TestConfigureDeploy(unittest2.TestCase):

    def setUp(self):
        request = testing.DummyRequest()
        self.config = testing.setUp(request=request)

    def tearDown(self):
        testing.tearDown()

    @patch('almir.scripts.configure_deploy.open', create=True)
    @patch('almir.lib.bconsole.BConsole.is_running')
    @patch('getpass.getpass')
    @patch('almir.scripts.configure_deploy.validate_engine')
    @patch('sys.stdout', spec=file)
    @patch('sys.stdin')
    def test_minimal_run(self, mock_stdin, mock_stdout, mock_validate_engine, mock_getpass, mock_is_running, mock_open):
        mock_stdin.readline.side_effect = ['\n', '\n', 'sqlite:///\n', '\n', '\n', '\n', '\n', '123123\n']
        mock_getpass.return_value = '123123'
        mock_is_running.return_value = True
        mock_open.return_value = MagicMock(spec=file)

        main()

        file_handle = mock_open.return_value.__enter__.return_value
        actual = file_handle.write.call_args[0][0]
        expected = """[buildout]
extends = buildout.d/production.cfg

[almir]
# define sql database connection as specified in
# http://docs.sqlalchemy.org/en/latest/core/engines.html#database-urls
#sqla_engine_url = sqlite:///%(here)s/bacula.db
#sqla_engine_url = postgresql+pg8000://bacula:<password>@hostname/<database>
#sqla_engine_url = mysql+mysqlconnector://bacula:<password>@hostname/<database>
sqla_engine_url = sqlite:///

# your timezone from TZ* column in table https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
# if not set, defaults to system timezone
#timezone = Europe/Ljubljana
timezone =

# configure http daemon
host = 127.0.0.1
port = 2500

# bconsole director parameters
director_name = localhost-dir
director_port = 9101
director_address = localhost
director_password = 123123
        """
        self.assertEqual(actual.replace(' ', '').replace('\n', ''),
                         expected.replace(' ', '').replace('\n', ''),
                         "%s != %s" % (actual, expected))

    @patch('almir.scripts.configure_deploy.open', create=True)
    @patch('almir.lib.bconsole.BConsole.is_running')
    @patch('getpass.getpass')
    @patch('sqlalchemy.create_engine')  # TODO: rather patch engine
    @patch('sys.stdout', spec=file)
    @patch('sys.stdin')
    def test_custom_run(self, mock_stdin, mock_stdout, mock_create_engine, mock_getpass, mock_is_running, mock_open):
        mock_stdin.readline.side_effect = [
            'localhost\n',  # host
            'asd\n',  # port
            '99999\n',  # port
            '80\n',  # port
            '45001\n',  # port
            '\n',  # sqla
            'sqlite:///bacula.db\n',  # sqla
            'DST\n',  # timezone
            'Europe/Ljubljana\n',  # timezone
            'almir\n',  # dir name
            '8.8.8.8\n',  # dir address
            '8080\n',  # dir port
            '666\n',  # dir password
        ]
        engine = mock_create_engine.return_value
        engine.table_names.return_value = ['Client', 'Job', 'Media']
        mock_getpass.return_value = '666'
        mock_is_running.return_value = True
        mock_open.return_value = MagicMock(spec=file)

        main()

        file_handle = mock_open.return_value.__enter__.return_value
        actual = file_handle.write.call_args[0][0]
        expected = """
[buildout]
extends = buildout.d/production.cfg

[almir]
# define sql database connection as specified in
# http://docs.sqlalchemy.org/en/latest/core/engines.html#database-urls
#sqla_engine_url = sqlite:///%(here)s/bacula.db
#sqla_engine_url = postgresql+pg8000://bacula:<password>@hostname/<database>
#sqla_engine_url = mysql+mysqlconnector://bacula:<password>@hostname/<database>
sqla_engine_url = sqlite:///bacula.db

# your timezone from TZ* column in table https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
# if not set, defaults to system timezone
#timezone = Europe/Ljubljana
timezone = Europe/Ljubljana

# configure http daemon
host = localhost
port = 45001

# bconsole director parameters
director_name = almir
director_port = 8080
director_address = 8.8.8.8
director_password = 666
        """
        self.assertEqual(actual.replace(' ', '').replace('\n', ''),
                         expected.replace(' ', '').replace('\n', ''),
                         "%s != %s" % (actual, expected))
