#!/bin/bash
set -e
SELF=`readlink -f $0`
DIR=`dirname $SELF`
if [ "$1" == "" ]; then
	NB_THREADS=$((`lscpu | grep "^CPU(s):" | sed -E "s/.* ([0-9]+)/\1/g"`))
else
	NB_THREADS=$1
fi

cd $DIR
if [ ! -d linux ]; then
	git clone --branch v5.14 --depth 1 https://github.com/torvalds/linux.git
fi
cd -

cd $DIR/linux
make distclean
yes "" | make oldconfig 2>&1 >/dev/null
/bin/time -p make -j$NB_THREADS
cd -
