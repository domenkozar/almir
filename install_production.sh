#!/bin/sh +e

git clone https://github.com/iElectric/almir.git -b latests .
python almir/scripts/configure_deploy.py
python bootstrap.py
bin/buildout
