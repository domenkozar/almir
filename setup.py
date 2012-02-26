import os
import sys

from setuptools import setup, find_packages

here = os.path.abspath(os.path.dirname(__file__))
README = open(os.path.join(here, 'README.rst')).read()
CHANGES = open(os.path.join(here, 'CHANGES.txt')).read()

requires = [
    'pyramid',
    'pyramid_tm',
    'pyramid_debugtoolbar',
    'pyramid_jinja2',
    'colander',
    'deform',
    'WebHelpers',
    'transaction',
    'SQLAlchemy',
    'zope.sqlalchemy',
    'gevent',  # http://michael.merickel.org/2011/6/21/tictactoe-and-long-polling-with-pyramid/
    'gunicorn',
    'waitress',
    # postgres
    'psycopg2',
    'psycogreen',  # TODO: mysql+gevent?
]

if sys.version_info[:3] < (2, 5, 0):
    requires.append('pysqlite')  # TODO: load all drivers

setup(name='almir',
      version='0.1',
      description='almir',
      long_description=README + '\n\n' + CHANGES,
      classifiers=[
        "Programming Language :: Python",
        "Framework :: Pylons",
        "Topic :: Internet :: WWW/HTTP",
        "Topic :: Internet :: WWW/HTTP :: WSGI :: Application",
      ],
      author=u'Domen Kozar',
      author_email='domen@dev.si',
      url='',
      keywords='web wsgi bfg pylons pyramid',
      packages=find_packages(),
      include_package_data=True,
      zip_safe=False,
      test_suite='almir',
      install_requires=requires,
      entry_points="""
      [paste.app_factory]
      main = almir:main

      [console_scripts]
      parse_console_commands = almir.scripts.parse_console_commands:main
      """,
      paster_plugins=['pyramid'],
      extras_require={
          'test': ['webtest', 'nose', 'coverage'],
      },
)
