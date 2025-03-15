#!/bin/bash

GAWK_SRC=$CACHE/gawk
download_and_untar "https://ftp.gnu.org/gnu/gawk/gawk-5.3.1.tar.xz" "$GAWK_SRC"

if [ ! -d $GAWK_SRC/build ]
then
  mkdir -p $GAWK_SRC/build
  cd $GAWK_SRC/build
  ../configure --prefix=/usr --sysconfdir=/etc --build=$(../build-aux/config.guess) --host=$TARGET
  make -j$(nproc)
fi
cd $GAWK_SRC/build
make DESTDIR=$ISO_SYSROOT install
