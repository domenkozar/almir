import os

from setuptools import setup, find_packages


here = os.path.abspath(os.path.dirname(__file__))
README = open(os.path.join(here, 'README.rst')).read()
CHANGES = open(os.path.join(here, 'docs', 'source', 'changelog.rst')).read()

requires = [
    'pyramid',
    'pyramid_tm',
    'pyramid_jinja2',
    'pyramid_exclog',
    'pyramid_beaker',
    'colander',
    'deform',
    'deform_bootstrap',
    'WebHelpers',
    'transaction',
    'SQLAlchemy',
    'zope.sqlalchemy',
    'waitress',
    'docutils',
    'pg8000',  # postgres
    'mysql-connector-repackaged',  # original one does not install with buildout
    'pytz',
]

try:
    import sqlite3
    sqlite3  # pyflakes
except ImportError:
    requires.append('pysqlite')

setup(name='almir',
      version='0.1.6',
      description='Almir is a Bacula (backup solution) web interface written in Python.',
      long_description=README + '\n\n' + CHANGES,
      classifiers=[
          "Programming Language :: Python",
          "Framework :: Pylons",
          "Topic :: Internet :: WWW/HTTP",
          "Topic :: Internet :: WWW/HTTP :: WSGI :: Application",
          "Topic :: System :: Archiving :: Backup",
          "License :: OSI Approved :: GNU General Public License (GPL)",
      ],
      author=u'Domen Kozar',
      author_email='domen@dev.si',
      url='',
      keywords='web pyramid bacula administration',
      packages=find_packages(),
      include_package_data=True,
      zip_safe=False,
      test_suite='almir',
      install_requires=requires,
      entry_points="""
      [paste.app_factory]
      main = almir:main

      [console_scripts]
      almir_parse_console_commands = almir.scripts.parse_console_commands:main
      """,
      #paster_plugins=['pyramid'],
      extras_require={
          'test': [
              'webtest',
              'nose',
              'coverage',
              'unittest2',
              'mock',
              'tissue',
          ],
          'develop': [
              'bpython',
              'z3c.checkversions [buildout]',
              'zest.releaser',
              'waitress',
              'pyramid_debugtoolbar',
              'Sphinx',
              'docutils',
          ],
      },
)
