Developer guide
===============

Setup developer environment
---------------------------

* sudo aptitude install libevent-dev git gcc python-dev bacula-console sendmail
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

    bin/nosetests


Running Javascript tests
------------------------

Install and configure phantomjs (webkit headless testing)::

    sudo apt-get install libqtwebkit-dev
    git clone git://github.com/ariya/phantomjs.git && cd phantomjs
    qmake-qt4 && make
    sudo cp bin/phantomjs /usr/local/bin/

Run tests::

    cd ../almir
    ./.travis_qunit_tests.sh
