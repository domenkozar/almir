#!/bin/sh +xe

git clone https://github.com/iElectric/almir.git -b latests .
echo "[buildout]\nextends = buildout.d/production.cfg" > buildout.cfg
python bootstrap.py
bin/buildout
bin/bpython almir/scripts/configure_deploy.py
bin/buildout -O
