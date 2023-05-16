#!/bin/bash
set -e
cd debian/tests
cmake -Bbuild
cd build
make; make test
