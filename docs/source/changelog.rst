Changelog
=========

0.1.5 (2013-03-27)
------------------

- [feature] Refactor the package a bit, so it's easier to package it for Linux distributions
  [Domen Kožar]

- [bug] Update MANIFEST.in so all files are included in release
  [Domen Kožar]

- [bug] Add new bootstrap.py and pin down zc.buildout version to avoid upgrading zc.buildout to 2.0
  [Domen Kožar]

- [feature] Add apache2 configuration example
  [Iban]

0.1.4 (2013/03/23)
------------------

- brownbag release

0.1.3 (2012/08/27)
------------------

- [bug] upgraded doctutils as it was failing buildout
  [Domen Kožar]

- removed some dependencies on production, upgraded zc.buildout to 1.6.3 for faster installation
  [Domen Kožar]

- determine version from distribution metadata
  [Domen Kožar]

0.1.2 (2012/05/31)
------------------

- [bug] interactive installer would swallow error message when SQL connection string was not formatted correctly

- [bug]: #7: don't word wrap size columns

- [feature] add manual install steps

- [bug] #4: client detail page did not render if client had no successful backup

- [bug] #5: correctly parse scheduled jobs (choked on Admin job)

- [feature] use python2.7 or python2.6, otherwise abort installation


0.1.1 (2012/04/18)
------------------

- [bug] fix support for postgresql 9.1
  [Domen Kožar]

- [feature] add reboot crontab for almir daemon
  [Domen Kožar]

- [bug] MySQL database size calculation was wrong, sometimes crashing the dashboard
  [Domen Kožar]

- [bug] console command list was not ordered and search box was not shown
  [Domen Kožar]

- [bug] bconsole did not accept non-asci input
  [Domen Kožar]


0.1 (2012/04/06)
----------------

- Initial version
  [Domen Kožar]
