#!/bin/bash
set -e
ncpu="$(grep 'processor' /proc/cpuinfo | wc -l)"
cd examples
cmake -Bbuild .
cd build
make -j${ncpu}
testbins=( $(find . -type f -executable | grep -v CMake) )
echo The testbins are: ${testbins[@]}
for bin in ${testbins[@]}; do
	echo running ${bin} ...
	if (echo ${bin} | grep -o fgbzip2); then
		./${bin} -b=9 -async ${bin}
	elif test tachyon = $(basename ${bin}); then
		echo skipped.
	elif (echo ${bin} | grep -o fractal); then
		./${bin} auto
	else
		./${bin}
	fi
done
cd ..
rm -rf build
