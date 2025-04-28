#!/bin/bash
set -e
ncpu="$(grep 'processor' /proc/cpuinfo | wc -l)"
cd examples
cmake -Bbuild .
cd build
make -j${ncpu}
testbins=( $(find . -type f -executable | sort | grep -v CMake) )
echo The testbins are: ${testbins[@]}
for bin in ${testbins[@]}; do
	echo running ${bin} ...
	if (echo ${bin} | grep -o fgbzip2 >/dev/null); then
		./${bin} -b=9 -async ${bin}
	elif test tachyon = $(basename ${bin}); then
		echo skipped.
	elif (echo ${bin} | grep -o fractal >/dev/null); then
		./${bin} auto max-of-iterations=1000
    elif (echo ${bin} | grep -o sub_string_finder_simple >/dev/null); then
        ./${bin} silent
    elif (echo ${bin} | grep -o logic_sim >/dev/null); then
        ./${bin} silent
    elif (echo ${bin} | grep -o recursive_fibonacci >/dev/null); then
        ./${bin} 32  # making test faster.
	else
		./${bin}
	fi
done
cd ..
rm -rf build
