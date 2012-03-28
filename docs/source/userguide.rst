.. highlight:: bash

User guide
==========


Screenshots
-----------

TODO ;)


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

* bacula is installed and bacula-director is running
* installed python2.6 or python2.7
* using postgresql: make sure `postgresql.conf` includes a line `client_encoding = utf8`


Installer (interactive)
***********************


Install prerequesities (Debian based)::

    $ sudo apt-get install git bacula-console

Install almir (recommended: under same user as bacula)::

    $ cd /some/directory/to/install/almir/
    $ sh -c "$(wget -O - https://raw.github.com/iElectric/almir/master/install_production.sh)"

You can continue with configuring :ref:`nginx`.

.. note::

    Installer will ask you few questions about SQL database and configuration for bconsole.

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
                # how to place and write htpasswd: http://wiki.nginx.org/HttpAuthBasicModule#auth_basic_user_file
                auth_basic_user_file htpasswd;

        }
    }

Then run::

    $ /etc/init.d/nginx reload

Now try to access http://almir.mywebsite.com/


Upgrading to a newer release
----------------------------

Currently it's best to just reinstall. In future, this will be easy as running a command.
Filesystem structure
--------------------

TODO ;)
