.. highlight:: bash

User guide
==========


Demo
----

http://almir-demo.domenkozar.com/

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

Almir will install everything inside one directory, which must be empty. Application is meant to be self-contained,
meaning no additional administrator is needed besides upgrading to a newer version. Almir should
be always installed on a system together with bacula-director.

Prerequisities
**************

* Bacula 5.x.x is installed and bacula-director is running
* installed python2.6 or python2.7 (compiled with sqlite support)
* using postgresql: make sure `postgresql.conf` includes a line `client_encoding = utf8`


Installer (interactive)
***********************


Install prerequesities (Debian based)::

    $ sudo apt-get install git bacula-console python-distribute

.. note::

    Installer will ask you few questions about SQL database and configuration for bconsole.

Install almir (recommended: under same user as bacula)::

    $ cd /some/empty/directory/to/install/almir/
    $ sh -xec "$(wget -O - https://raw.github.com/iElectric/almir/master/install_production.sh)"

You can continue with configuring :ref:`nginx`.


Manual (not recommended)
************************

TODO ;)

.. _nginx:

Configuring Nginx as frontend
*****************************

You would normally put this in /etc/nginx/sites-enabled/

.. code-block:: nginx 

    server {
        listen          80;
        server_name     almir.mywebsite.com;

        location / {
                proxy_pass http://localhost:2500;

                proxy_set_header  X-Real-IP  $remote_addr;
                proxy_set_header  X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header  Host $http_host;
                proxy_redirect off;

                # optional authentication - recommended
                auth_basic "Restricted";
                # how to correctly write htpasswd: http://wiki.nginx.org/HttpAuthBasicModule#auth_basic_user_file
                auth_basic_user_file /some/directory/to/install/almir/.htpasswd;

        }
    }

Then run::

    $ /etc/init.d/nginx reload

Now try to access http://almir.mywebsite.com/ (if you have an error, follow instructions at :ref:`reporting-bugs`)


Upgrading to a newer release
----------------------------

Run::

    $ cd almir_install_directory
    $ git pull
    $ bin/buildout
    $ bin/supervisorctl shutdown
    $ bin/supervisord

You can also use that in crontab to auto upgrade on new releases, if you are crazy enough. You would probably extra check if upgrade is needed, something like running following and checking for any output::

    $ git log latests..origin/latests

.. _reporting-bugs:

Reporting bugs
--------------

Check if an issue already exists at https://github.com/iElectric/almir/issues,
otherwise add new one with following information: 

* bacula-director version, operating system and browser version
* include screenshot if it provides any useful information
* pastebin (http://paste2.org) output of $ cat ALMIR_ROOT/var/logs/almir-stderr*
* pastebin ALMIR_ROOT/buildout.cfg, but be careful to *remove any sensitive data*


Filesystem structure
--------------------

TODO ;)
