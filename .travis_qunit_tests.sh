#!/bin/sh -xe
DISPLAY=:99.0 find almir/tests/javascript/ -iname test_*.html -exec phantomjs almir/tests/javascript/run-qunit.js file://`pwd`/{} \;
