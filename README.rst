Setup development environment
=============================

* sudo aptitude install libevent-dev git gcc python-dev bacula-console sendmail
* git clone https://github.com/iElectric/almir.git almir
* cd almir
* cp buildout.d/templates/buildout.cfg.in buildout.cfg  # edit buildout.cfg
* python bootstrap.py
* bin/buildout
* bin/pserve --reload development.ini


Deliverables
============

* supports bacula-director version 5.0.x (others MIGHT work)
* supports python 2.6 and 2.7
* 100% test coverage
