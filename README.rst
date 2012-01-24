Setup development environment
=============================

* sudo aptitude install libevent-dev
* git clone https://github.com/iElectric/almir.git almir
* cd almir
* python2.7 bootstrap.py
* cp buildout.d/templates/buildout.cfg.in buildout.cfg  # specify correct parameter to connect to bacula SQL DB (use tunnels to servers)
* bin/buildout
* bin/pserve --reload development.ini

Deliverables
============

* supports bacula-director version 5.0.x (others MIGHT work)
* 100% test coverage
