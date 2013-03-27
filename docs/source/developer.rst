.. highlight:: bash

Developer guide
===============

Setup developer environment
---------------------------

* sudo aptitude install git gcc python-dev bacula-console
* git clone https://github.com/iElectric/almir.git almir
* cd almir
* cp buildout.d/templates/buildout.cfg.in buildout.cfg 
* vim buildout.cfg  # configure variables
* python bootstrap.py
* bin/buildout
* bin/pserve --reload development.ini


Running Python tests
--------------------

Easy as::

    $ bin/nosetests

By default it will run against sqlite fixture, you can also tell nosetests to use mysql fixture (you need to import sql manually for now)::

    $ DATABASE="mysql" bin/nosetests

Or just specify sqlalchemy engine::

    $ ENGINE="sqlite:////var/lib/bacula/bacula.db" bin/nosetests


Running Javascript tests
------------------------

Install and configure phantomjs (webkit headless testing)::

    $ sudo apt-get install libqtwebkit-dev
    $ git clone git://github.com/ariya/phantomjs.git && cd phantomjs
    $ qmake-qt4 && make
    $ sudo cp bin/phantomjs /usr/local/bin/

Run tests::

    $ cd ../almir
    $ ./.travis_qunit_tests.sh


Coding conventions
------------------

* `PEP8 <http://www.python.org/dev/peps/pep-0008/>`_ except for 80 char length rule
* add changelog, test and documentation with code in commits
* same applies to javascript
* jslinted javascript


Releasing :mod:`almir`
----------------------

::

    $ bin/fullrelease
    $ git checkout latests
    $ git merge master
    $ git push --tags
    $ git push 
    # update http://readthedocs.org/dashboard/almir/versions/
