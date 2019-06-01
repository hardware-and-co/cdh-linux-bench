#!/bin/bash
if [ "$1" == "" ]; then
	NB_THREADS=$((1+`lscpu | grep "^CPU(s):" | sed -E "s/.*([0-9]+).*/\1/g"`))
else
	NB_THREADS=$1
fi

if [ ! -d linux ]; then
	git clone --branch v5.1 --depth 1 https://github.com/torvalds/linux.git
fi

cd linux
yes "" | make oldconfig 2>&1 >/dev/null
make clean 2>&1 >/dev/null
time make -j$NB_THREADS
cd ..
