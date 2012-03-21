#!/bin/sh -xe

git clone https://github.com/iElectric/almir.git -b latests .
echo -e "[buildout]\nextends = buildout.d/production.cfg" > buildout.cfg
python bootstrap.py
bin/buildout
bin/python almir/scripts/configure_deploy.py
bin/buildout -O
bin/supervisord
echo
echo
echo 'Congratulations, almir is starting and may take about 10 seconds to listen on port you specified! Now you can:'
echo
echo '1) configure reverse-proxy on nginx/apache. Sample nginx config: http://readthedocs.org/docs/almir/en/latest/userguide.html#configuring-nginx-as-frontend'
echo "2) change settings: vim buildout.cfg && bin/buildout && bin/supervisorctl restart all"
