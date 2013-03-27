#!/bin/sh
set +xe
PYTHON_EXEC=$(which python2.7 || which python2.6)

set -xe
[ -z $PYTHON_EXEC ] && $(which echo) "No python2.7 or python2.6 binary found, exiting" && exit 1
git clone https://github.com/iElectric/almir.git -b latests .
printf "[buildout]\nextends = buildout.d/production.cfg" > buildout.cfg
$PYTHON_EXEC bootstrap.py -v 1.7.1
bin/buildout
bin/python almir/scripts/configure_deploy.py
bin/buildout -o
bin/supervisord
set +xe
echo
echo
echo 'Congratulations, almir is starting and may take about 10 seconds to listen on port you specified! Now you can:'
echo
echo '1) configure reverse-proxy on nginx/apache. Sample nginx config: http://readthedocs.org/docs/almir/en/latest/userguide.html#configuring-nginx-as-frontend'
echo "2) change settings: vim buildout.cfg && bin/buildout && bin/supervisorctl restart all"
