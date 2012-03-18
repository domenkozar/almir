.. highlight:: bash

User guide
==========


Screenshots
-----------


Design goals
------------

* each release is pinned to bacula-director specific major version
* simple is better than complicated
* inline documentation
* convention over configuration
* can act as view interface only (optional configuration functionality)
* plugin into existing bacula instance
* total control of bacula through existing bacula api


Installation
------------

Almir will install everything inside on directory. Application is meant to be self-contained,
meaning no additional administrator is needed besides upgrading to a newer version. Almir should
be always installed on a system together with bacula-director.

Note that currently python2.6 and python2.7 are supported.

If you are using postresql, make sure `postgresql.conf` includes a line `client_encoding = utf8`

Buildout (recommended)
**********************

Install prerequesities (Debian based)::

    $ sudo apt-get install git bacula-console

Install almir::

    $ cd /some/directory/to/install/almir/
    $ sh -c "$(wget -O - https://raw.github.com/iElectric/almir/master/install_production.sh)"


Manual (not recommended)
************************

Configuring Nginx as frontend
*****************************

Filesystem structure
--------------------
