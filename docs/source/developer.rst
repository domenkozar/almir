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
