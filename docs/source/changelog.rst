Changelog
=========

\

0.1.2 (2012/xx/xx)
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
