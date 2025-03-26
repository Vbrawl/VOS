#!/bin/bash

POPT_SRC=$CACHE/popt
$ROOT/download_and_untar.sh "https://github.com/rpm-software-management/popt/archive/refs/tags/popt-1.19-release.tar.gz" "$POPT_SRC"

if [ ! -d $POPT_SRC/build ]
then
  cd $POPT_SRC
  ./autogen.sh

  mkdir -p $POPT_SRC/build
  cd $POPT_SRC/build
  ../configure --prefix=/usr --build=$(../build-aux/config.guess) --host=$TARGET --disable-nls
  make -j$(nproc)
fi
cd $POPT_SRC/build
make DESTDIR=$ISO_SYSROOT install
